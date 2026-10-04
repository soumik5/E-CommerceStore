terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# ---------------------------------------------------------
# VPC
# ---------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ecommerce-vpc"
  }
}

# ---------------------------------------------------------
# Public Subnet
# ---------------------------------------------------------

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-public-subnet"
  }
}

# ---------------------------------------------------------
# Internet Gateway
# ---------------------------------------------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-igw"
  }
}

# ---------------------------------------------------------
# Route Table
# ---------------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "ecommerce-public-route-table"
  }
}

# Associate route table with public subnet

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------

resource "aws_security_group" "ecommerce" {
  name        = "ecommerce-security-group"
  description = "Security group for ecommerce application"
  vpc_id      = aws_vpc.main.id

  # Frontend - public access
  ingress {
    description = "Frontend HTTP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Backend services - internal communication
  ingress {
    description = "User service"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Product service"
    from_port   = 3002
    to_port     = 3002
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Order service"
    from_port   = 3003
    to_port     = 3003
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Cart service"
    from_port   = 3004
    to_port     = 3004
    protocol    = "tcp"
    self        = true
  }

  # SSH - useful for testing/debugging
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecommerce-security-group"
  }
}

# ---------------------------------------------------------
# Amazon Linux 2023 AMI
# ---------------------------------------------------------

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# ---------------------------------------------------------
# EC2 Instance
# ---------------------------------------------------------

resource "aws_instance" "ecommerce" {
  ami = data.aws_ssm_parameter.al2023.value

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.ecommerce.id
  ]

  key_name = var.key_name

  user_data = templatefile("${path.module}/user_data.sh", {
    frontend_image = var.frontend_image
    user_image     = var.user_image
    product_image  = var.product_image
    order_image    = var.order_image
    cart_image     = var.cart_image
  })

  user_data_replace_on_change = true

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "ecommerce-docker-server"
  }
}
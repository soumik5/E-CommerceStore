variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "frontend_image" {
  type    = string
  default = "soumik5/e-commercestore-frontend:v1"
}

variable "user_image" {
  type    = string
  default = "soumik5/e-commercestore-user-service:v1"
}

variable "product_image" {
  type    = string
  default = "soumik5/e-commercestore-product-service:v1"
}

variable "order_image" {
  type    = string
  default = "soumik5/e-commercestore-order-service:v1"
}

variable "cart_image" {
  type    = string
  default = "soumik5/e-commercestore-cart-service:v1"
}
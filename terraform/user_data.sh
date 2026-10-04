#!/bin/bash

set -e

echo "======================================"
echo "Starting Ecommerce Server Setup"
echo "======================================"

# Update packages
dnf update -y

# Install Docker
dnf install -y docker

# Start Docker
systemctl start docker
systemctl enable docker

# Allow ec2-user to use Docker
usermod -aG docker ec2-user

echo "Docker installed successfully"

# Wait for Docker
sleep 10

# Pull Docker images
echo "Pulling frontend image..."
docker pull ${frontend_image}

echo "Pulling user service image..."
docker pull ${user_image}

echo "Pulling product service image..."
docker pull ${product_image}

echo "Pulling order service image..."
docker pull ${order_image}

echo "Pulling cart service image..."
docker pull ${cart_image}

echo "All images pulled successfully"

# Create Docker network
docker network create ecommerce-network || true

# ---------------------------------------------------------
# User Service
# ---------------------------------------------------------

docker rm -f user-service 2>/dev/null || true

docker run -d \
  --name user-service \
  --network ecommerce-network \
  -p 3001:3001 \
  ${user_image}

# ---------------------------------------------------------
# Product Service
# ---------------------------------------------------------

docker rm -f product-service 2>/dev/null || true

docker run -d \
  --name product-service \
  --network ecommerce-network \
  -p 3002:3002 \
  ${product_image}

# ---------------------------------------------------------
# Order Service
# ---------------------------------------------------------

docker rm -f order-service 2>/dev/null || true

docker run -d \
  --name order-service \
  --network ecommerce-network \
  -p 3003:3003 \
  ${order_image}

# ---------------------------------------------------------
# Cart Service
# ---------------------------------------------------------

docker rm -f cart-service 2>/dev/null || true

docker run -d \
  --name cart-service \
  --network ecommerce-network \
  -p 3004:3004 \
  ${cart_image}

# ---------------------------------------------------------
# Frontend
# ---------------------------------------------------------

docker rm -f frontend 2>/dev/null || true

docker run -d \
  --name frontend \
  --network ecommerce-network \
  -p 3000:3000 \
  ${frontend_image}

echo "======================================"
echo "All containers started"
echo "======================================"

# Show running containers
docker ps
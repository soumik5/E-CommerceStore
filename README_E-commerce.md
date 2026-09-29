# Deploy a Multi-Service Node.js E-commerce Application Using Terraform and Docker
# Requirements and implementation steps: 
- ##  Local Implementation:
local Installation
1. Clone the repository
```
git clone https://github.com/soumik5/E-CommerceStore.git
cd  E-CommerceStore/
```
 <img width="791" height="862" alt="image" src="https://github.com/user-attachments/assets/0d7444be-f514-45de-a220-950921259d88" />

2. Install dependencies for each service
```
# Install User Service dependencies
cd backend/user-service && npm install

# Install Product Service dependencies
cd ../product-service && npm install

# Install Cart Service dependencies
cd ../cart-service && npm install

# Install Order Service dependencies
cd ../order-service && npm install

# Install Frontend dependencies
cd ../../frontend && npm install
```
<img width="861" height="917" alt="image" src="https://github.com/user-attachments/assets/90e0e1c8-fc0c-4fdd-bd9c-d9feea55b84d" />
<img width="1877" height="972" alt="image" src="https://github.com/user-attachments/assets/b9552fd4-348c-4dfb-b05d-145291e3b359" />

3. Set up environment variables
backend/user-service/.env:
```
PORT=3001
MONGODB_URI=mongodb://localhost:27017/ecommerce_users
JWT_SECRET=your-jwt-secret-key
backend/product-service/.env:

PORT=3002
MONGODB_URI=mongodb://localhost:27017/ecommerce_products
backend/cart-service/.env:

PORT=3003
MONGODB_URI=mongodb://localhost:27017/ecommerce_carts
PRODUCT_SERVICE_URL=http://localhost:3002
backend/order-service/.env:

PORT=3004
MONGODB_URI=mongodb://localhost:27017/ecommerce_orders
CART_SERVICE_URL=http://localhost:3003
PRODUCT_SERVICE_URL=http://localhost:3002
USER_SERVICE_URL=http://localhost:3001
```
frontend/.env:
```
REACT_APP_USER_SERVICE_URL=http://localhost:3001
REACT_APP_PRODUCT_SERVICE_URL=http://localhost:3002
REACT_APP_CART_SERVICE_URL=http://localhost:3003
REACT_APP_ORDER_SERVICE_URL=http://localhost:3004
```


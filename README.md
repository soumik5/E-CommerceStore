# Deploy a Multi-Service Node.js E-commerce Application Using Terraform and Docker
# Requirements and implementation steps: 
- # Local Implementation:
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

3. **Set up environment variables**

Create `.env` files in each service directory:

**backend/user-service/.env:**
```env
PORT=3001
MONGODB_URI=mongodb://localhost:27017/ecommerce_users
JWT_SECRET=your-jwt-secret-key
```

**backend/product-service/.env:**
```env
PORT=3002
MONGODB_URI=mongodb://localhost:27017/ecommerce_products
```

**backend/cart-service/.env:**
```env
PORT=3003
MONGODB_URI=mongodb://localhost:27017/ecommerce_carts
PRODUCT_SERVICE_URL=http://localhost:3002
```

**backend/order-service/.env:**
```env
PORT=3004
MONGODB_URI=mongodb://localhost:27017/ecommerce_orders
CART_SERVICE_URL=http://localhost:3003
PRODUCT_SERVICE_URL=http://localhost:3002
USER_SERVICE_URL=http://localhost:3001
```

**frontend/.env:**
```env
REACT_APP_USER_SERVICE_URL=http://localhost:3001
REACT_APP_PRODUCT_SERVICE_URL=http://localhost:3002
REACT_APP_CART_SERVICE_URL=http://localhost:3003
REACT_APP_ORDER_SERVICE_URL=http://localhost:3004
```

### Running the Application


** Run services individually**

Terminal 1 - User Service:
```bash
cd backend/user-service && npm start
```
<img width="722" height="497" alt="image" src="https://github.com/user-attachments/assets/fab58abe-f244-448d-90fe-a60b3c700f64" />


Terminal 2 - Product Service:
```bash
cd backend/product-service && npm start
```
<img width="902" height="502" alt="image" src="https://github.com/user-attachments/assets/d3b67241-030d-4f7e-a291-afe96cb49021" />

Terminal 3 - Cart Service:
```bash
cd backend/cart-service && npm start
```
<img width="1621" height="952" alt="image" src="https://github.com/user-attachments/assets/8e34bd83-c4a6-4cf3-b9ae-b4d55e5b7b2d" />

Terminal 4 - Order Service:
```bash
cd backend/order-service && npm start
```
<img width="885" height="576" alt="image" src="https://github.com/user-attachments/assets/f9c307b2-286e-4c0d-ae5b-d3e0cc6357f0" />

Terminal 5 - Frontend:
```bash
cd frontend && npm start
```
<img width="1887" height="841" alt="image" src="https://github.com/user-attachments/assets/b854d879-f8b1-40c9-9c98-b836980206b5" />

The application will be available at:
- Frontend: http://localhost:3000
<img width="1917" height="850" alt="image" src="https://github.com/user-attachments/assets/e438d80b-0f49-4bb3-bf4b-bb433686bc55" />

- User Service: http://localhost:3001
<img width="532" height="332" alt="image" src="https://github.com/user-attachments/assets/8a662700-14ed-45d8-8eef-6c18ac4a17b0" />

- Product Service: http://localhost:3002
<img width="570" height="375" alt="image" src="https://github.com/user-attachments/assets/dd34f5e7-9013-454f-bba1-a6626c50c030" />

- Cart Service: http://localhost:3003
<img width="696" height="502" alt="image" src="https://github.com/user-attachments/assets/b6c54b43-36ac-46f7-b54d-349de03bbd9b" />

- Order Service: http://localhost:3004
<img width="567" height="287" alt="image" src="https://github.com/user-attachments/assets/bed2faf8-9272-4190-87ef-95094e42feb4" />

- #  Application Setup (Docker)

### 1. Create Dockerfiles for each of the 5 services: (Each service must expose a relevant port and return a sample response (e.g., "user Service Running")
- Frontend Dockerfile:
<img width="940" height="646" alt="image" src="https://github.com/user-attachments/assets/4108acc2-b44a-42a8-aff8-ba674d86978f" />

- Backend user-service Dockerfile:
<img width="900" height="715" alt="image" src="https://github.com/user-attachments/assets/349a466e-b0b1-4591-af0d-74de851be41a" />

- Backend product-service Dockerfile:
<img width="851" height="677" alt="image" src="https://github.com/user-attachments/assets/41749d82-3c15-4eaa-9193-d65eacdfe49d" />

- Backend order-service Dockerfile:
<img width="887" height="697" alt="image" src="https://github.com/user-attachments/assets/0fbd6c91-0ddc-40fa-8fd3-41c94e391125" />

- Backend cart-service Dockerfile:
<img width="802" height="757" alt="image" src="https://github.com/user-attachments/assets/2606f189-e435-45e6-aac0-a23a225e6c49" />


### 2. Build and test the Docker images locally

- created Docker-compose.yaml file to build the images locally. the file is placed at the root of the git repo for your reference.


### 3. Tag and push the images to Docker Hub 
- pushed all the docker images to my dockerhub.

<img width="1917" height="572" alt="image" src="https://github.com/user-attachments/assets/2c00f333-564f-4d5e-8495-27164ed80370" />

- #  Infrastructure Provisioning with Terraform

<img width="772" height="882" alt="image" src="https://github.com/user-attachments/assets/3675d16c-ff07-44c8-8b88-43999ce51901" />
<img width="1312" height="1030" alt="image" src="https://github.com/user-attachments/assets/4cc9f107-7fe8-4853-b82e-e463bd9a85d4" />



### 1. VPC with at least one public subnet:

#### VPC with at least one public subnet is created. Please refer to terraform.tfstate file for your reference

<img width="1582" height="370" alt="image" src="https://github.com/user-attachments/assets/6ab311b8-8571-471b-9f64-e70541343cc3" />


### 2. 1 or more EC2 Instances to host the Docker containers

#### one EC2 Instance is also created to host the Docker containers. Please refer to terraform.tfstate file for your reference.

<img width="1656" height="457" alt="image" src="https://github.com/user-attachments/assets/429dad39-6859-4d61-b698-292d039541af" />


### 3. Security Groups to allow: 
- #### Inbound HTTP (port 80 or 3000) to the frontend

#### Inbound rule allowed for HTTP (port 80 or 3000) to the frontend
                                                               
- #### Internal communication between services (custom ports, e.g., 3001–3004) 

#### Internal communication between services (custom ports, e.g., 3001–3004) are also there.

<img width="1797" height="746" alt="image" src="https://github.com/user-attachments/assets/131d583c-7892-4c99-b82a-9878169dac32" />

### 4. Use Terraform provisioners or user-data scripts to:


- Install Docker on EC2

- Pull all 5 images from Docker Hub

- Run the containers on proper portsDocker 

- Docker is installed in EC2 via user-data script and it has successfully pulled all the images from Dockerhub and containers are also running on proper ports.

  <img width="1670" height="447" alt="image" src="https://github.com/user-attachments/assets/4e62a828-f97a-42d9-869b-63fe4af61d3c" />

- # Deployment and Accessibility

### 1. Ensure the frontend service is publicly accessible 
#### you can see frontend is live and publicly accessible.

<img width="1911" height="840" alt="image" src="https://github.com/user-attachments/assets/a3812882-0941-4c60-b7e7-f838ae85d8a5" />


### 2. Verify backend containers are running.

#### Backend containers are already up and running.

<img width="1732" height="422" alt="image" src="https://github.com/user-attachments/assets/5a2d596e-e4c7-450e-9a10-262f65790744" />


### 3. Use Terraform output to print the public IP or DNS of the application

<img width="687" height="121" alt="image" src="https://github.com/user-attachments/assets/e0589f9b-b496-41ee-9e63-d4475dfc85fb" />





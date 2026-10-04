FROM node:alpine AS Builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .


FROM node:slim AS Production
WORKDIR /app
COPY --from=Builder /app .
EXPOSE 3004
CMD ["npm", "start"]
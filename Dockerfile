# --- Build Stage ---
FROM node:20 AS build

WORKDIR /app

# Copy package files 
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY . .

# Build for production
RUN npm run build --configuration production

# --- Production Stage ---
FROM nginx:1.27-alpine

# Copy built files to Nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

FROM node:20 AS build

WORKDIR /app
COPY package*.json ./
COPY . .

RUN npm ci

RUN npm run build -- --configuration production

FROM nginx:1.27-alpine
COPY --from=build /app/dist/banking-portal/ usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

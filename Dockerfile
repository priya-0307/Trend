# Stage 1: Build (optional if using frameworks like React/Vue)
# FROM node:18 AS builder
# WORKDIR /app
# COPY . .
# RUN npm install && npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY dist/html/ /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

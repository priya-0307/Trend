# Use compatible Node version for Vite
FROM node:20.19.0-alpine AS build

WORKDIR /app

# Copy only necessary files
COPY package*.json ./
COPY vite.config.* ./
COPY index.html ./
COPY src ./src

RUN npm install && npm run build

# Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

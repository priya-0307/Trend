# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --silent

# Copy the rest of the source code
COPY . .

# Build the app
#RUN npm run build

# Stage 2: Serve
FROM node:18-alpine
WORKDIR /app

# Install a simple server to serve the built files
RUN npm install -g serve

# Copy build output from builder
COPY --from=builder /app/dist ./dist

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "dist", "-l", "3000"]

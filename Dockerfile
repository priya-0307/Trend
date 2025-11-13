# Stage 1: build
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .
# RUN npm run build

# Stage 2: runtime
FROM node:18-alpine AS runner
WORKDIR /app
RUN npm i -g serve
COPY --from=builder /app/dist ./dist
EXPOSE 3000
# serve static build on port 3000
CMD ["serve", "-s", "build", "-l", "3000"]

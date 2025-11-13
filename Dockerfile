# Stage 1: build
FROM node:18-alpine AS builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: runtime
FROM node:18-alpine AS runner
WORKDIR /app
RUN npm i -g serve
COPY --from=builder /app/build ./build
EXPOSE 3000
# serve static build on port 3000
CMD ["serve", "-s", "build", "-l", "3000"]

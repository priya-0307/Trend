# build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --silent
COPY . .
#RUN npm run build   # adjust if build output is `build` or `dist`

# runtime stage
FROM node:18-alpine
WORKDIR /app
ENV PORT=3000
RUN npm install -g serve
COPY --from=builder /app/dist /app/dist   # change /dist to /build if needed
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]

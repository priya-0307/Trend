# Use Node.js lightweight image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install serve globally
RUN npm install -g serve

# Copy prebuilt dist folder
COPY dist/ ./dist

# Expose port 3000
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "dist", "-l", "3000"]

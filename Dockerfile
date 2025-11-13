# Use lightweight Node.js image
FROM node:20-alpine

# Set working directory inside the container
WORKDIR /app

# Install 'serve' globally to serve static files
RUN npm install -g serve

# Copy your built React app (dist folder) into the container
COPY dist/ ./dist

# Set environment variable for the port
ENV PORT=3000

# Expose port 3000 to the outside
EXPOSE 3000

# Start the app using serve
CMD ["serve", "-s", "dist", "-l", "3000"]

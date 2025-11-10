# ---------------------------
# Frontend Dockerfile for React
# ---------------------------

# Use Node 18 lightweight image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy frontend folder content
COPY frontend/ .

# Install npm dependencies
RUN npm install

# Expose React dev server port
EXPOSE 3000

# Start the frontend (same as your local "npm start")
CMD ["npm", "start"]

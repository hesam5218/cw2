# Use the official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY server.js .

# Install dependencies (if any are added later)
# RUN npm install

# Expose port 8080 for the application
EXPOSE 80

# Define the command to run the application
CMD ["node", "server.js"]

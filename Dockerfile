# Use the official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY server.js .

# Expose port 3000 for the application (adjusted to match the run command)
EXPOSE 8081  443

# Define the command to run the application
CMD ["node", "server.js"]


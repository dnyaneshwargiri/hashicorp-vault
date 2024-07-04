# Use the official Node.js image as the base image
FROM node:21
# Set the working directory
WORKDIR /usr/src/app

# Set the Environment Variables
ARG POSTGRES_USER  
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB
ARG POSTGRES_PORT
ARG POSTGRES_HOST

ENV POSTGRES_USER=$POSTGRES_USER  
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_PORT=$POSTGRES_PORT
ENV POSTGRES_HOST=$POSTGRES_HOST

# Copy the rest of the application code to the working directory
COPY dist/* ./
# Expose the port your app runs on
EXPOSE 3000
# Define the command to run your app
CMD ["node", "index.js"]


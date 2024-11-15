# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install dependencies for cowsay, fortune, and netcat with clean up and fix-missing
RUN apt-get update && \
    apt-get install -y --fix-missing cowsay fortune netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the wisecow.sh script into the container
COPY wisecow.sh .

# Make the wisecow.sh script executable
RUN chmod +x wisecow.sh

# Expose port 4499 to the host
EXPOSE 4499

# Define the command to run when the container starts
CMD ["./wisecow.sh"]

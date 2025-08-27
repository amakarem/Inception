FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js and dependencies
RUN apt-get update && \
    apt-get install -y curl build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Copy Node.js project from ./site into container
COPY site/package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the app (server.js + public folder)
COPY site/ ./

# Expose port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]

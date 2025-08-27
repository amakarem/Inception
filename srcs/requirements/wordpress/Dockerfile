# Base image
FROM debian:bullseye

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install PHP, extensions, curl, vim, mailutils, and cleanup
RUN apt-get update -y && \
    apt-get install -y \
        php-fpm \
        php-mysql \
        php-zip \
        php-redis \
        curl \
        vim \
        mailutils \
        unzip \
        gnupg2 \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM to listen on port 9000
RUN sed -i -e 's/listen = .*/listen = 9000/g' /etc/php/*/fpm/pool.d/www.conf

# Create PHP runtime directory
RUN mkdir -p /run/php

# Set working directory
WORKDIR /var/www/html

# Ensure www-data owns the web directory
RUN chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core (allow root for Docker container)
RUN wp core download --allow-root

# Copy custom script
COPY ./tools/script.sh /tmp/script.sh

# Make script executable
RUN chmod +x /tmp/script.sh

# Set entrypoint
ENTRYPOINT ["bash", "/tmp/script.sh"]

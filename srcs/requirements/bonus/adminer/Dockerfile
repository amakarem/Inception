FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, and curl
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql php-mbstring curl && \
    rm -rf /var/lib/apt/lists/*

# Switch MPM to prefork (required for mod_php)
RUN a2dismod mpm_event && a2enmod mpm_prefork

# Enable PHP and dir modules
RUN a2enmod php7.4 dir

# Suppress ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set DirectoryIndex to prioritize PHP files
RUN echo "DirectoryIndex index.php index.html" >> /etc/apache2/apache2.conf

# Remove default Apache index.html
RUN rm -f /var/www/html/index.html

# Download the actual latest Adminer PHP file
RUN curl -L -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port inside container
EXPOSE 8080

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

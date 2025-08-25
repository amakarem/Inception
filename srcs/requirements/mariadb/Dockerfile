FROM debian:bullseye

# Install MariaDB non-interactively
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y mariadb-server pwgen && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

# Copy startup script
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Allow remote connections
RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Run the script as entrypoint
ENTRYPOINT ["bash", "/tmp/script.sh"]

# Default command (start mysqld safely)
CMD ["mysqld_safe"]

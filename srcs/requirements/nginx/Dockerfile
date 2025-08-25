FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/certs.sh /tmp/certs.sh
RUN chmod +x /tmp/certs.sh

COPY ./conf/default /etc/nginx/sites-available/default

ENTRYPOINT ["/tmp/certs.sh"]

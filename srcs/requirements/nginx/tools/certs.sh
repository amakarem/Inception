#!/bin/bash

: "${domain_name:?Need to set domain_name}"
: "${username:?Need to set username}"

mkdir -p /etc/ssl/certs /etc/ssl/private

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/${domain_name}.key \
    -out /etc/ssl/certs/${domain_name}.crt \
    -subj "/C=DE/ST=Heilbronn/L=Heilbronn/O=42Heilbronn/OU=${username}/CN=${domain_name}"

# Replace $domain_name in nginx config
sed -i "s/\$domain_name/${domain_name}/g" /etc/nginx/sites-available/default

# Start nginx
nginx -g 'daemon off;'

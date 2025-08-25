#!/bin/bash
# Replace ${USERNAME} in template
envsubst '${USERNAME}' < /etc/nginx/sites-available/default.template > /etc/nginx/sites-available/default

# Start nginx
nginx -g 'daemon off;'

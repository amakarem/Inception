#!/bin/bash
envsubst '${USERNAME}' < /etc/nginx/sites-available/default > /etc/nginx/sites-available/default

# Start nginx
nginx -g 'daemon off;'

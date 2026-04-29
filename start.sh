#!/bin/bash

echo "Starting page rotation..."
/usr/share/nginx/html/rotate_pages.sh &

echo "Starting nginx..."
nginx -g "daemon off;"

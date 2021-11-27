#! /usr/bin/env /bin/bash
# clear
echo "# nginx status from http://0.0.0.0/nginx_status (only locally)."
wget --quiet http://0.0.0.0/nginx_status -O -

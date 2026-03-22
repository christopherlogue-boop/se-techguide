#!/bin/sh
# If PASSWORD env var is set, compute its SHA-256 hash and inject into the HTML
if [ -n "$PASSWORD" ]; then
  HASH=$(printf '%s' "$PASSWORD" | sha256sum | awk '{print $1}')
  sed -i "s|const PASSWORD_HASH = '[^']*'|const PASSWORD_HASH = '${HASH}'|" /usr/share/nginx/html/index.html
fi
exec nginx -g 'daemon off;'

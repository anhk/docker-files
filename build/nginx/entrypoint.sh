#!/bin/bash

if [ -z "$SERVER_NAME" ]; then
    echo >&2 '[Entrypint] ERROR: Please set $SERVER_NAME'
    exit 1
fi

if [ -z "$PROXY_BACKEND" ]; then
    echo >&2 '[Entrypint] ERROR: Please set $PROXY_BACKEND'
    exit 1
fi

sed -i "s@{{server-name}}@$SERVER_NAME@" /etc/nginx/nginx.conf
sed -i "s@{{proxy-backend}}@$PROXY_BACKEND@" /etc/nginx/nginx.conf

exec "$@"

#!/bin/bash

if [ -z "$SS_PORT" ]; then
    echo -e "[Entrypint] \033[32m\$SS_PORT\033[0m Using default Port: \033[31m1445\033[0m"
    SS_PORT=1445
fi

if [ -z "$SS_METHOD" ]; then
    echo -e "[Entrypint] \033[32m\$SS_METHOD\033[0m Using default Method: \033[31m chacha20 \033[0m"
    SS_METHOD="chacha20"
fi

if [ -z "$SS_PASSWORD" ]; then
    SS_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    echo -e "[Entrypint] \033[32m\$SS_PASSWORD\033[0m Using Random Password: \033[31m $SS_PASSWORD \033[0m"
fi

cat > /etc/ssconfig/ss.json << EOF
{
    "server": "0.0.0.0",
    "server_port": $SS_PORT,
    "password": "$SS_PASSWORD",
    "method": "$SS_METHOD",
    "timeout": 60
}
EOF

exec "$@"

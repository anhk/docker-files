#!/bin/bash

set -e

GUACDSRC=https://github.com/apache/guacamole-server/archive/refs/tags/1.5.0.tar.gz

wget -O- ${GUACDSRC} | tar xz

cd guacamole-server-1.5.0

# M1 chip MacOS
if [ "$(uname -s)" = "Darwin" -a "$(uname -m)" = "arm64" ]; then
    sed -i "" 's/DWITH_SSE2=ON/DWITH_SSE2=OFF/' Dockerfile
fi


ARCH=$(uname -m)
VERSION=$(date +%Y%m%d%H%M)

if [ "$ARCH" = "x86_64" ]; then
    ARCH=amd64
fi

docker build -f Dockerfile \
    -t ir0cn/guacd:$ARCH.$VERSION .

cd -

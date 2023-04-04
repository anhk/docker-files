#!/bin/bash

arch=$(uname -m)
version=$(date +%Y%m%d%H%M)
image="kube-apiserver"

if [ "$arch" = "x86_64" ]; then
    arch=amd64
fi

docker build -f Dockerfile --no-cache \
    -t $image:$arch.$version .

docker tag $image:$arch.$version $image:latest

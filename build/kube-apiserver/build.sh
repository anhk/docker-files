#!/bin/bash

arch=$(uname -m)
version=$(date +%Y%m%d%H%M)
image="ir0cn/kube-apiserver"

if [ "$arch" = "x86_64" ]; then
    arch=amd64
fi

docker buildx build -f Dockerfile \
    -t $image:$arch.$version .

docker tag $image:$arch.$version $image:latest

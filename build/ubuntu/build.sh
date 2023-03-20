#!/bin/bash

#docker buildx build --platform linux/amd64,linux/arm64/v8 --push -t quay.io/xxfe/ubuntu .
docker buildx build --platform linux/amd64,linux/arm64/v8 --push -t ir0cn/ubuntu .

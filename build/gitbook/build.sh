#!/bin/bash

docker buildx build --platform linux/amd64,linux/arm64/v8 --push -t ir0cn/gitbook .

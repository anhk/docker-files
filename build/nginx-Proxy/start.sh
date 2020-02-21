#!/bin/bash

docker run -it --rm \
    -v $(pwd)/certs:/etc/nginx/certs \
    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
    nginx-proxy

#!/bin/bash

docker run -p 80:80 -v $(pwd)/sslBook:/site/content -it --rm ir0cn/hugo

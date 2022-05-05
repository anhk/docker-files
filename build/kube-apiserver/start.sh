#!/bin/bash

docker stop kube-apiserver && docker rm kube-apiserver
docker run -itd --name kube-apiserver -p 2379:2379 -p 6443:6443 ir0cn/kube-apiserver

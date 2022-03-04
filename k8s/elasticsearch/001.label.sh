#!/bin/bash


# 删除label
kubectl label nodes node01 es-data-
kubectl label nodes node02 es-data-

# 添加label
kubectl label nodes node01 es-data=true
kubectl label nodes node02 es-data=true

# 查看Label
echo "es-data=true: "
kubectl get nodes -l "es-data=true"

#!/bin/bash


# 删除label
kubectl label nodes node01 es-data-node-
kubectl label nodes node02 es-data-node-

kubectl label nodes node01 es-data-master-
kubectl label nodes node02 es-data-master-

# 添加label
kubectl label nodes node01 es-data-node=true
kubectl label nodes node02 es-data-node=true

kubectl label nodes node01 es-data-master=true
kubectl label nodes node02 es-data-master=true

# 查看Label
echo "es-data-node=true: "
kubectl get nodes -l "es-data-node=true"

echo "es-data-master=true: "
kubectl get nodes -l "es-data-master=true"

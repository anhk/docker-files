#!/bin/bash

docker-compose up -d
docker-compose scale redis=8

IP1=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_1)
IP2=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_2)
IP3=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_3)
IP4=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_4)
IP5=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_5)
IP6=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_6)
IP7=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_7)
IP8=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_8)

redis-cli --cluster create $IP1:6379 $IP2:6379 $IP3:6379 $IP4:6379 $IP5:6379 $IP6:6379 $IP7:6379 $IP8:6379 --cluster-replicas 1

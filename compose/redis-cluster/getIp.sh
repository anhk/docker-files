#!/bin/bash

#IP1=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_1)
#IP2=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_2)
#IP3=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_3)
#IP4=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_4)
#IP5=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_5)
#IP6=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_6)
#IP7=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_7)
#IP8=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_8)

for ((i=1;i<9;i++)); do
    IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rediscluster_redis_$i)
    echo rediscluster_redis_$i $IP
done

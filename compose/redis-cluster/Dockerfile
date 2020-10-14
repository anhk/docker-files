FROM redis
#FROM redis:4.0

RUN echo 'port 6379 \n\
cluster-enabled yes \n\
cluster-config-file nodes.conf \n\
cluster-node-timeout 5000 \n\
appendonly yes \n\
' > /etc/redis.conf

CMD [ "redis-server", "/etc/redis.conf" ]


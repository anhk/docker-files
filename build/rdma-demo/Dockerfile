FROM ubuntu

RUN apt-get update && apt-get install -y rdma-core ibverbs-utils perftest libibverbs1 rdmacm-utils && \
    apt clean && rm -fr /var/lib/apt/lists/* 

WORKDIR /root

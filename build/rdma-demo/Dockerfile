FROM ubuntu

RUN apt update -y && apt install -y rdma-core ibverbs-utils perftest libibverbs1 rdmacm-utils \
        curl ncat pciutils wget iputils-ping traceroute && \
    apt clean && rm -fr /var/lib/apt/lists/* 

WORKDIR /root

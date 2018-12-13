FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y shadowsocks-libev simple-obfs && \
    rm -rf /var/lib/apt/lists/*

ADD ./entrypoint.sh /entrypoint.sh

VOLUME ["/etc/ssconfig"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["ss-server", "-c", "/etc/ssconfig/ss.json", "-u"]



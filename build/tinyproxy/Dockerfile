FROM alpine:3
MAINTAINER EasyPi Software Foundation

RUN set -xe \
    && apk add --no-cache tinyproxy iptables \
    && sed -i -e '/^Allow /s/^/#/' \
              -e '/^ConnectPort /s/^/#/' \
              -e '/^#DisableViaHeader /s/^#//' \
              /etc/tinyproxy/tinyproxy.conf

VOLUME /etc/tinyproxy
EXPOSE 8888

CMD ["tinyproxy", "-d"]

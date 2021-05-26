FROM ubuntu:latest as build

LABEL maintainer="anhk@ir0.cn"

# dependency
RUN set -x \
    && apt-get update \
    && apt-get install build-essential libpcre3-dev zlib1g-dev unzip wget git -y \
    && rm -fr /usr/local

RUN set -x \
    && wget 'https://github.com/guanzhi/GmSSL/archive/refs/heads/master.zip' -O GmSSL-master.zip \
    && unzip GmSSL-master.zip \
    && cd GmSSL-master \
    && sed -i 's@ => qw/glob/;@ => qw/:glob/;@' Configure \
    && sed -i 's@ => qw/glob/;@ => qw/:glob/;@' test/build.info \
    && ./config \
    && sed -i 's@LDFLAGS=@LDFLAGS= -Wl,-rpath=$(LIBRPATH)@' Makefile \
    && make && make install


FROM ubuntu:latest

COPY --from=build /usr/local /usr/local

WORKDIR /root

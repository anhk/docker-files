FROM ubuntu:latest

LABEL maintainer="anhk@anhk.cc"

RUN apt-get update

# dependency
RUN set -x \
    && apt-get install build-essential libpcre3 libpcre3-dev zlib1g-dev unzip git -y

RUN apt-get install wget

# module nginx-ct
RUN set -x  \
    && wget -O nginx-ct.zip -c https://github.com/grahamedgecombe/nginx-ct/archive/v1.3.2.zip \
    && unzip nginx-ct.zip

# module ngx_brotli
RUN set -x \
    && git clone https://github.com/google/ngx_brotli.git \
    && cd ngx_brotli \
    && git submodule update --init

# openssl 1.3
RUN set -x \
    && git clone -b 'OpenSSL_1_1_1-stable' --single-branch --depth 1 https://github.com/openssl/openssl.git openssl

# build and install nginx
RUN set -x \
    && wget -c https://nginx.org/download/nginx-1.15.8.tar.gz \
    && tar zxf nginx-1.15.8.tar.gz \
    && cd nginx-1.15.8 \
    && ./configure --prefix=/ --add-module=../ngx_brotli --add-module=../nginx-ct-1.3.2 --with-openssl=../openssl --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers' --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module \
    && make \
    && make install

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


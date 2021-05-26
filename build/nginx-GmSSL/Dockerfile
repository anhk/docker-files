FROM ubuntu:latest as build

LABEL maintainer="anhk@ir0.cn"

# dependency
RUN set -x \
    && apt-get update \
    && apt-get install build-essential libpcre3-dev zlib1g-dev unzip wget git -y

RUN set -x \
    && wget 'https://github.com/guanzhi/GmSSL/archive/refs/heads/master.zip' -O GmSSL-master.zip \
    && unzip GmSSL-master.zip \
    && cd GmSSL-master \
    && sed -i 's@ => qw/glob/;@ => qw/:glob/;@' Configure \
    && sed -i 's@ => qw/glob/;@ => qw/:glob/;@' test/build.info

RUN set -x \
    && wget https://github.com/pengtianabc/nginx-gm/archive/refs/heads/master.zip -O nginx-gm-master.zip \
    && unzip nginx-gm-master.zip \
    && cd nginx-gm-master \
    && sed -i 's@--with-openssl=/mnt/g/Git/GmSSL@--with-openssl=/GmSSL-master@' build.sh \
    && chmod +x ./build.sh && ./build.sh && make && make install

FROM ubuntu:latest
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /etc/nginx /etc/nginx

RUN useradd nginx && mkdir -p /var/cache/nginx /var/www/html /usr/lib/nginx/modules /var/log/nginx/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
WORKDIR "/root"


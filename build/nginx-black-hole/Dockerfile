FROM ubuntu:latest as build

LABEL maintainer="anhk@anhk.cc"

# dependency
RUN set -x \
    && apt-get update \
    && apt-get install build-essential libpcre3-dev zlib1g-dev unzip wget git -y

# build and install nginx
RUN set -x \
    && wget -c https://nginx.org/download/nginx-1.15.8.tar.gz \
    && git clone https://github.com/anhk/nginx-black-hole.git \
    && tar zxf nginx-1.15.8.tar.gz \
    && cd nginx-1.15.8 \
    && ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --add-module=../nginx-black-hole \
    && make \
    && make install

FROM ubuntu:latest
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /etc/nginx /etc/nginx
COPY nginx.conf /etc/nginx/nginx.conf

RUN useradd nginx && mkdir -p /var/cache/nginx /var/www/html /usr/lib/nginx/modules /var/log/nginx/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


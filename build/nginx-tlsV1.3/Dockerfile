FROM ubuntu:latest as build

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
    && ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.15.8/debian/debuild-base/nginx-1.15.8=. -specs=/usr/share/dpkg/no-pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-specs=/usr/share/dpkg/no-pie-link.specs -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' --add-module=../ngx_brotli --add-module=../nginx-ct-1.3.2 --with-openssl=../openssl --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers'  \
    && make \
    && make install

FROM ubuntu:latest
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /etc/nginx /etc/nginx

#RUN apt-get -y remove wget build-essential libpcre3-dev zlib1g-dev unzip git
#RUN apt-get -y autoremove
#RUN apt-get clean &&  rm -rf /var/lib/apt/lists/*
#RUN rm -fr nginx-1.15.8 nginx-1.15.8.tar.gz nginx-ct.zip nginx-ct-1.3.2 ngx_brotli openssl

RUN useradd nginx && mkdir -p /var/cache/nginx /var/www/html /usr/lib/nginx/modules /var/log/nginx/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM alpine

# Install Nginx.
#RUN apt-get update && \
#  apt-get install -y nginx libnginx-mod-http-lua && \
#  rm -rf /var/lib/apt/lists/* && \
#  chown -R www-data:www-data /var/lib/nginx

#RUN rm -fr /etc/nginx && mkdir -p /etc/nginx/certs

ADD ./frps /bin/frps
ADD ./frps.ini /etc/frps.ini
ADD ./frpc /bin/frpc
ADD ./frpc.ini /etc/frpc.ini

# Define mountable directories.
#VOLUME ["/etc/nginx/certs", "/var/log/nginx", "/var/www/html"]

# Define working directory.
#WORKDIR /etc/nginx

# Define default command.
#ENTRYPOINT ["/entrypoint.sh"]
#CMD ["nginx", "-g", "daemon off;"]

# Expose ports.
#EXPOSE 80
#EXPOSE 443

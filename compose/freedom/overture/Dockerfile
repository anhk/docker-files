FROM ubuntu

ADD ./overture-v1.4-linux-amd64/overture-linux-amd64 /bin/overture
ADD ./config.json /etc/overture/overture.json

RUN touch /etc/overture/domain_alternative \
/etc/overture/domain_primary \
/etc/overture/ip_network_alternative \
/etc/overture/ip_network_primary

EXPOSE 53 53/udp

CMD ["overture", "-c", "/etc/overture/overture.json"]


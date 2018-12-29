FROM ubuntu:16.04

MAINTAINER anhk <anhk@anhk.cc>

RUN apt-get update &&               \
    apt-get install -y libjpeg8 libid3tag0 libsqlite3-0 libavformat-ffmpeg56 libexif12 libflac8 && \
    apt-get clean &&                \
    rm -rf /var/lib/apt/lists/*

ADD minidlnad /usr/sbin/minidlnad
ADD minidlna.conf /etc/minidlna.conf
ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

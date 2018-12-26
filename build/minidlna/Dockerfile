FROM debian:jessie-backports

MAINTAINER anhk <anhk@anhk.cc>

RUN apt-get update && apt-get -t jessie-backports install -y minidlna

ADD entrypoint.sh /entrypoint.sh

CMD ["/run.sh"]

docker run -it --restart always -v $(pwd)/ssconfig:/etc/ssconfig -p 1445:1445 --name ss-server -d anhk/ss-server ss-server -c /etc/ssconfig/ss.json -u


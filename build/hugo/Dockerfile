FROM ubuntu

ADD ./hugo /bin/hugo
ONBUILD RUN /bin/hugo new site /site/
ADD ./book /site/themes/book
ADD ./config.yml /site/config.yml

VOLUME ["/site/content"]
WORKDIR /site/

CMD ["/bin/hugo", "server", "--bind", "0.0.0.0", "-p", "80", "--appendPort=false", "--baseUrl=https://ssl.ir0.cn/"]

EXPOSE 80

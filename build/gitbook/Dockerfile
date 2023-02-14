FROM node:12

RUN npm config set registry https://registry.npm.taobao.org && \
    npm install -g gitbook-cli@2.1.2 && gitbook install

WORKDIR /root

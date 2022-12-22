
FROM node:16 as build

WORKDIR /root

RUN git clone https://github.com/xksec/www.xksec.com

RUN cd www.xksec.com && npm install && npm run build


FROM nginx

COPY --from=build /root/www.xksec.com/dist/* /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]

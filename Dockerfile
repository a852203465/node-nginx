FROM nginx:1.23.3-alpine

MAINTAINER Rong.Jia 852203465@qq.com

COPY ./bin/entrypoint.sh /usr/local/entrypoint.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/conf.d/default.conf /etc/nginx/conf.d/default.conf

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN apk add --no-cache \
        libstdc++ \
        bash

WORKDIR /opt

RUN chmod +x /usr/local/entrypoint.sh

WORKDIR /etc/nginx

ENTRYPOINT ["/usr/local/entrypoint.sh"]




























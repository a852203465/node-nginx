# 基础镜像
FROM nginx:1.20.0-alpine

# 作者
MAINTAINER Rong.Jia 852203465@qq.com

ENV YARN_VERSION 1.22.10
ENV NODE_VERSION 16.2.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python3 \
        wget

WORKDIR /opt

# 安装node
RUN wget https://npm.taobao.org/mirrors/node/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz \
    && tar zxvf node-v$NODE_VERSION.tar.gz \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -rf "node-v$NODE_VERSION" node-v$NODE_VERSION.tar.gz

RUN wget https://github.com/yarnpkg/yarn/releases/download/v$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz \
    && tar zxvf yarn-v$YARN_VERSION.tar.gz \
    && rm -rf yarn-v$YARN_VERSION.tar.gz

WORKDIR /

# 安装 yarn
RUN ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && apk del .build-deps-yarn \
    && npm install cnpm -g \
    && npm install -g cnpm --registry=http://registry.npm.taobao.org

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

























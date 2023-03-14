# 基础镜像
FROM nginx:1.23.3-alpine

# 作者
MAINTAINER Rong.Jia 852203465@qq.com

ENV YARN_VERSION 1.22.19
ENV NODE_VERSION 19.7.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

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
        wget \
     && apk add --no-cache --virtual .build-deps-yarn \
        curl \
        gnupg \
        tar

WORKDIR /opt

RUN wget https://npm.taobao.org/mirrors/node/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz \
    && tar zxvf node-v${NODE_VERSION}.tar.gz \
    && cd "node-v${NODE_VERSION}" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -rf "node-v${NODE_VERSION}" node-v${NODE_VERSION}.tar.gz

RUN wget https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz \
    && tar zxvf yarn-v${YARN_VERSION}.tar.gz \
    && rm -rf yarn-v${YARN_VERSION}.tar.gz

WORKDIR /

RUN ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg \
    && apk del .build-deps-yarn \
    && npm install cnpm -g --registry=http://registry.npmmirror.com \
    && npm config set registry http://registry.npmmirror.com \
    && yarn config set registry http://registry.npmmirror.com

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
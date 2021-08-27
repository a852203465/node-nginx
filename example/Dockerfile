FROM registry.cn-shenzhen.aliyuncs.com/a852203465/node-nginx:1.1

RUN mkdir /home/web

ADD ./dev-pord-switch.tar.gz /home/web

RUN npm config set registry http://registry.npm.taobao.org\
  && npm config set sass_binary_site http://npm.taobao.org/mirrors/node-sass\
  && cd /home/web\
  && npm config get registry\
  && cnpm install

RUN echo -e '#!/bin/sh\ 
  \nif [ -d "/home/web" ];then\
  \ncd /home/web\
  \nnpm run build\
  \ncp -a "/home/web/dist/." /usr/share/nginx/html/\
  \nrm -rf /home/web\
  \nnginx -g "daemon off;"\
  \nelse\
  \nnginx -g "daemon off;"\
  \nfi' > /home/docker-run.sh\
  && chmod +x /home/docker-run.sh

ENTRYPOINT ["/home/docker-run.sh"]

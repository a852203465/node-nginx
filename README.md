# 制作 Node + Nginx 运行环境镜像

## 版本说明
### v1.0
 - 基于Node 16.2.0, Nginx 1.20.0-alpine, Yarn 1.22.10

### v1.1
 - 基于Node 14.17.5, Nginx 1.20.0-alpine, Yarn 1.22.10
 - 修改编译方式

### v1.2
 - 基于Node 12-alpine, Nginx 1.20.1, Yarn 1.22.10
 - 修改编译方式，处理镜像过大问题

### v1.3
- 基于Node 19, Nginx 1.23.3, Yarn 1.22.19

## 运行

### 自行build docker镜像
 1. 执行build.sh 文件即可

### 直接拉取镜像
 1. docker pull registry.cn-shenzhen.aliyuncs.com/a852203465/node-nginx:<version>
















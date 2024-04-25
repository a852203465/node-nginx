# 基于node-nginx 镜像完成node 环境切换

## 运行

 1. 先执行根目录的build.sh文件生成base 镜像
 2. 把dev-pord-switch.tar.gz打开项目，然后打包项目,再把打包的dist压缩包上传到服务器
 3. 在example目录执行docker-compose up -d --build
 4. 访问ip:port 即可查看环境是否切换成功

















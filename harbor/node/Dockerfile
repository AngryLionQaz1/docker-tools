#制定nginx镜像的版本
FROM nginx:1.17.2-alpine
#声明作者
MAINTAINER xiaoyi
#移动当前目录下面的文件到app目录下
COPY  dist /usr/share/nginx/html/
EXPOSE 80
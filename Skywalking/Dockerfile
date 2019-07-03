FROM centos:7
MAINTAINER 127.0.0.1@qq.com
# Timezone, Asia/Shanghai by default
ENV Timezone=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$Timezone /etc/localtime && echo '$Timezone' > /etc/timezone

RUN yum install -y wget && \
    yum install -y java-1.8.0-openjdk

ADD apache-skywalking-apm-6.2.0.tar.gz /usr/local

WORKDIR /usr/local

RUN mv apache-skywalking-apm-bin skywalking && \
    echo "tail -f /dev/null" >> /usr/local/skywalking/bin/startup.sh


CMD ["/bin/sh","-c","/usr/local/skywalking/bin/startup.sh" ]
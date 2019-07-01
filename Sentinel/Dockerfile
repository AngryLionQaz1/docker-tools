FROM java:8-jre-alpine
MAINTAINER 127.0.0.1@qq.com
ENV JAVA_OPTS null
RUN mkdir -p /usr/tools/Sentinel
ADD sentinel-dashboard-1.6.2.jar /usr/tools/Sentinel/
WORKDIR /usr/tools/Sentinel
EXPOSE 8080
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar sentinel-dashboard-1.6.2.jar" ]
VOLUME /usr/tools/Sentinel:/usr/tools/Sentinel

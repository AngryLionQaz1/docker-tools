FROM openjdk:8-jdk-alpine
WORKDIR /app
VOLUME /app
COPY target/xiaoyi-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8086
ENV JAVA_OPTS="-server -Xms256m -Xmx512m"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar" ]

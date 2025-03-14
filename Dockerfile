FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y openjdk-11-jdk \
    && apt-get install -y maven wget\
    && wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.2/bin/apache-tomcat-11.0.2.tar.gz \
    && tar -vxzf apache-tomcat-11.0.2.tar.gz \
    && rm -rf apache-tomcat-11.0.2.tar.gz \
    && mv apache-tomcat-11.0.2 /usr/local/tomcat/ \
    && chmod +x /usr/local/tomcat/bin/*.sh \
    && mkdir -p /usr/local/tomcat/webapps \
    && rm -rf /var/lib/apt/lists/*
COPY ./target/gamutkart.war /usr/local/tomcat/webapps/
COPY Dockerfile /usr/local/tomcat/

EXPOSE 8082
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]



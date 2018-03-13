FROM java:openjdk-8-jdk
ENV http_proxy=http://www-proxy.us.oracle.com:80
ENV https_proxy=https://www-proxy.us.oracle.com:80
ENV spark_ver 2.2.1

#ADD demo-0.0.1-SNAPSHOT-shaded.jar /
ADD start-common.sh start-worker start-master /
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
#ADD config.properties config.properties
RUN mkdir -p  winutils/bin/
ADD winutils.exe winutils/bin/
ADD doc.txt doc.txt

ADD hadoop-2.7.3 opt/hadoop/lib/native
ADD spark-2.2.1-bin-hadoop2.7 opt/spark	

ENV PATH $PATH:/opt/spark/bin
RUN mkdir -p /opt/spark/lib
ADD mysql-connector-java-5.1.6.jar opt/spark/lib
ADD gcs-connector-latest-hadoop2.jar opt/spark/lib

RUN apt-get update && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/*

#ADD log4j.properties /opt/spark/conf/log4j.properties


EXPOSE 8080
EXPOSE 8082
EXPOSE 6066
EXPOSE 8081
#spark://spark-master:7077
#ENTRYPOINT ["spark-submit","--class","com.example.demo.DemoApplication","--master","local","demo-0.0.1-SNAPSHOT-shaded.jar"]
FROM tomcat:8.0-jre8
RUN apt-get update && apt-get install -y \
    ca-certificates-java \
    openjdk-8-jre tzdata \
    mysql-client && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf $CATALINA_HOME/webapps/
ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp -XX:+ExitOnOutOfMemoryError -XX:+PrintFlagsFinal"
ADD logging.properties server.xml $CATALINA_HOME/conf/
ADD docker-entrypoint.sh .
EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]

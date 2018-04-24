FROM tomcat:8.0.32-jre8
ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp -XX:+ExitOnOutOfMemoryError -XX:+PrintFlagsFinal"
RUN rm -rf $CATALINA_HOME/webapps
ADD docker-entrypoint.sh .
EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]

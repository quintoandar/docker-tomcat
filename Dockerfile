FROM tomcat:8.0.44-jre8
ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XX:+PrintFlagsFinal"
RUN rm -rf $CATALINA_HOME/webapps
ADD docker-entrypoint.sh .
EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]

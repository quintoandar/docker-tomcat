#!/bin/bash
# This scripts reads all environment variables passed to the tomcat container
# and injects them into the tomcat service through the CATALINA_OPTS variable

# env_keys greps all environment variables and excludes those that are default
# to the tomcat:8.0.44-jre8 container and most of those from DCOS, leaving 
# only those passed by Docker

env_keys() {
	env | awk -F= '/[\s]*=/ {
        	if (!system("[ -n \"${" $1 "+y}\" ]")) print $1 }' \
		| sort | uniq \
		| grep -vE "^_$" \
		| grep -vE "^CA_CERTIFICATES_JAVA_VERSION$" \
		| grep -vE "^CATALINA_HOME$" \
		| grep -vE "^GPG_KEYS$" \
		| grep -vE "^HOME$" \
		| grep -vE "^HOSTNAME$" \
		| grep -vE "^JAVA_DEBIAN_VERSION$" \
		| grep -vE "^JAVA_HOME$" \
		| grep -vE "^JAVA_OPTS$" \
		| grep -vE "^JAVA_VERSION$" \
		| grep -vE "^LANG$" \
		| grep -vE "^LIBPROCESS_IP$" \
		| grep -vE "^LD_LIBRARY_PATH$" \
		| grep -vE "^MARATHON_" \
		| grep -vE "^MESOS_" \
		| grep -vE "^OPENSSL_VERSION" \
		| grep -vE "^PATH$" \
		| grep -vE "^PWD$" \
		| grep -vE "^SHLVL" \
		| grep -vE "^TERM$" \
		| grep -vE "^TOMCAT_ASC_URL$" \
		| grep -vE "^TOMCAT_MAJOR$" \
		| grep -vE "^TOMCAT_NATIVE_LIBDIR$" \
		| grep -vE "^TOMCAT_TGZ_URL$" \
		| grep -vE "^TOMCAT_VERSION$"
}

env_keys | while IFS= read -r key; do
	val=$(eval "echo \$$key")
	CATALINA_OPTS="${CATALINA_OPTS} -D${key}=${val}"
	echo ${CATALINA_OPTS} > ./catalina_opts
done

export CATALINA_OPTS="$(cat ./catalina_opts) $@"
echo $CATALINA_OPTS
exec catalina.sh run


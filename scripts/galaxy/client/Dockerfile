
# Use tomcat as base for the build
ARG TOMCAT_VERSION=jdk8-openjdk-slim
FROM tomcat:${TOMCAT_VERSION}

# Copy profiles to container
COPY etc "/etc"

# Copy build artifacts into this stage
COPY ezremote.war /usr/local/tomcat/webapps/

# Expose the default listener port
EXPOSE 8080

CMD ["catalina.sh","run"]
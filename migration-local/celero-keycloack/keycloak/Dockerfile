ARG MAVEN_DOCKER_IMAGE
ARG KEYCLOAK_DOCKER_IMAGE

FROM $MAVEN_DOCKER_IMAGE AS build
WORKDIR /tmp/
COPY pom.xml /tmp/
COPY src /tmp/src
RUN mvn clean package

FROM $KEYCLOAK_DOCKER_IMAGE
USER root
COPY --from=build /tmp/target/*.jar /opt/keycloak/providers/app.jar
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]

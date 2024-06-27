FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /tmp/
COPY pom.xml /tmp/
COPY src /tmp/src
RUN mvn clean package

FROM quay.io/keycloak/keycloak:24.0.2
USER root
COPY --from=build /tmp/target/*.jar /opt/keycloak/providers/app.jar
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh" ,"start-dev"]

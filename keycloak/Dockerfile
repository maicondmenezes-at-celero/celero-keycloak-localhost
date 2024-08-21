FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /tmp/
COPY extensions/pom.xml /tmp/
COPY extensions/ /tmp/

# Download dependencies first to cache them
RUN mvn dependency:go-offline

# Copy Source Code
COPY . /tmp/

# Build the application
RUN mvn clean package -DskipTests

FROM quay.io/keycloak/keycloak:24.0.2
USER root

# Copy the built artifacts from the build image
COPY --from=build /tmp/extensions/*/target/*.jar /opt/keycloak/providers/app.jar

# Copy Custom Providers
COPY ./extensions/*.jar /opt/keycloak/providers/

# Copy theme resources
COPY ./themes/base/ /opt/keycloak/themes/base/
COPY ./themes/myclient/ /opt/keycloak/themes/myclient/

RUN chown -R keycloak:keycloak /opt/keycloak/themes/

USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh" ,"start-dev", "--verbose"]

FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN ls -l /app/services/user-service && cat /app/settings.gradle
RUN ./gradlew projects
ARG SERVICE_NAME
RUN ./gradlew :services/${SERVICE_NAME}:clean :services/${SERVICE_NAME}:build -x integrationTest -x test

FROM eclipse-temurin:21-jre
WORKDIR /app
ARG SERVICE_NAME
COPY --from=build /app/services/${SERVICE_NAME}/build/libs/${SERVICE_NAME}-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
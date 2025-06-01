FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY . .
RUN ./gradlew clean build -x integrationTest -x test
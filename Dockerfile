# Stage 1: Build the application
FROM maven:3.8.6-openjdk-11 AS builder
WORKDIR /tickets-platform
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:11-jdk
WORKDIR /tickets-platform
COPY --from=builder /tickets-platform/target/tickets-api.jar tickets-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "tickets-api.jar"]

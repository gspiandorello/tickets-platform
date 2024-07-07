# Stage 1: Build the application
FROM maven:3.8.6-openjdk-18 AS builder
WORKDIR /tickets-platform
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:18-jdk
WORKDIR /tickets-platform
COPY --from=builder /tickets-platform/target/tickets-platform-0.0.1-SNAPSHOT.jar tickets-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "tickets-api.jar"]

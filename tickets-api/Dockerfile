# Stage 1: Build the application
FROM maven:3.8.6-openjdk-21 AS builder
WORKDIR /tickets-api
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:21-jdk
WORKDIR /tickets-api
COPY --from=builder /tickets-api/target/tickets-api.jar tickets-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "tickets-api.jar"]

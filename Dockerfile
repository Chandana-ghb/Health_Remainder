# Use Maven image to build the project
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn -DskipTests package

# Use JDK runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose Render's dynamic port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

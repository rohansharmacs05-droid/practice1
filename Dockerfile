
# Stage 1: Build Maven project
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Stage 2: Run the application
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy generated JAR file
COPY --from=build /app/target/CalculatorProject-1.0-SNAPSHOT.jar app.jar

# Run calculator application
CMD ["java", "-cp", "app.jar", "com.example.App"]

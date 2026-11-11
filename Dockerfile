
# Stage 1: Build the Maven project
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Copy Java source files
COPY src ./src

# Compile and package the project
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the generated JAR
COPY --from=build /app/target/*.jar app.jar

# Execute calculator
CMD ["java", "-cp", "app.jar", "com.example.App"]

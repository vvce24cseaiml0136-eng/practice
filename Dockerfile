
# ==========================================
# STAGE 1: BUILD
# Maven + JDK 17
# ==========================================

FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Copy source code
COPY src ./src

# Download dependencies
RUN mvn dependency:go-offline -B

# Run TestNG tests and package project
RUN mvn clean package

# ==========================================
# STAGE 2: RUNTIME
# JDK 17
# ==========================================

FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy compiled classes
COPY --from=build /app/target/classes ./classes

# Run Even-Odd application
CMD ["java", "-cp", "classes", "com.example.vvce.evenodd.App"]

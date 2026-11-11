
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean test

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/classes ./classes

CMD ["java", "-cp", "classes", "com.example.vvce.evenodd.App"]

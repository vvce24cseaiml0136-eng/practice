
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

# Compile Selenium TestNG test classes
RUN mvn test-compile


# ==========================================
# STAGE 2: RUNTIME
# Maven + JDK 17 + Chromium
# ==========================================

FROM maven:3.9.9-eclipse-temurin-17

WORKDIR /app

# Update package lists and install Chromium
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY --from=build /app /app

# Copy Maven dependencies
COPY --from=build /root/.m2 /root/.m2

# Chromium configuration
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER=/usr/bin/chromedriver

# Run Selenium TestNG tests
CMD ["mvn", "test"]

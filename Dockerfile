# Stage 1 — Maven Build
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2 — Tomcat Runtime
FROM tomcat:9.0-jdk21-openjdk-slim
# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# CRITICAL STEP: Remove default ROOT app that causes conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR to Tomcat as ROOT.war to serve at "/"
COPY --from=build /app/target/civicfix.war /usr/local/tomcat/webapps/ROOT.war

# Create directory for file uploads
RUN mkdir -p /usr/local/tomcat/webapps/uploads/complaints

# Set JVM memory options to stay within Render's free tier limits
ENV JAVA_OPTS="-Xms128m -Xmx400m -XX:+UseG1GC"

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

CMD ["catalina.sh", "run"]

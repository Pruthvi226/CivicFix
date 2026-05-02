# Build Stage
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Run Stage
FROM tomcat:9.0-jdk17-openjdk-slim
WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*
COPY --from=build /app/target/*.war webapps/ROOT.war

# Set environment variables for Render (Render provides $PORT)
ENV PORT=8080
EXPOSE 8080

# Custom startup script to handle Port binding and DB properties
CMD ["catalina.sh", "run"]

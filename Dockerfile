# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application in Tomcat
FROM tomcat:9.0-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/

# Remove default Tomcat apps
RUN rm -rf ./ROOT ./examples ./docs ./manager ./host-manager

# Copy the WAR file from the build stage
COPY --from=build /app/target/CivicFix-1.0-SNAPSHOT.war ./ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

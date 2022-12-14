#
# Build stage
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8-jre-slim as package
COPY --from=build /home/app/target/eureka-server-0.0.1-SNAPSHOT.jar /usr/local/lib/eureka-server.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/usr/local/lib/eureka-server.jar"]
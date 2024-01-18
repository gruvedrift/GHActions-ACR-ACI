#!/bin/bash

# Copy and build jar
FROM gradle:7-jdk11 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle buildFatJar --no-daemon


# Run app
FROM openjdk:11
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/coop-de-grace.jar
ENTRYPOINT ["java", "-jar", "/app/coop-de-grace.jar"]

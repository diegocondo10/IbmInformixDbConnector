FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM openjdk:17-slim
ENV TZ=America/Bogota
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 5690
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar

# docker build -t ibm-informix-db-connector:latest .
# docker run -d -p 5690:5690 ibm-informix-db-connector:latest

# docker tag ibm-informix-db-connector:latest libelulasoft/ibm-informix-db-connector:latest
# docker push libelulasoft/ibm-informix-db-connector:latest

# Step 1: Build inside Maven image
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# -Dmaven.test.skip=true jodne se tests bypass ho jayenge
RUN mvn clean package -Dmaven.test.skip=true -DskipTests

# Step 2: Use standard JRE image
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.war app.war

RUN mkdir -p src/main/webapp
COPY --from=build /app/src/main/webapp/ src/main/webapp/

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
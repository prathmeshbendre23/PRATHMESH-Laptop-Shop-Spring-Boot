# Step 1: Build inside Maven image
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Use standard JRE image (Embedded Tomcat version)
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the generated war/jar file
COPY --from=build /app/target/*.war app.war

# Create the exploded webapp directory structure inside the container 
# This is the golden trick for JSP support in embedded spring boot!
RUN mkdir -p src/main/webapp
COPY --from=build /app/src/main/webapp/ src/main/webapp/

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
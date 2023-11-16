# Usar una imagen base de Java 17
FROM openjdk:17-slim

# Instalar Maven
RUN apt-get update && \
    apt-get install -y maven

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar solo el pom.xml y descargar dependencias
COPY ./pom.xml ./pom.xml

# Copiar el proyecto al contenedor
COPY . /app


# Compilar el proyecto con las dependencias necesarias
RUN mvn clean install

# Ejecutar la aplicación con Spring Boot DevTools para livereload
CMD ["mvn", "spring-boot:run"]

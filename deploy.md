# Documentación Técnica Despliegue

## Preparación Inicial del Servidor

### 1. Actualización de Dependencias

Es crucial mantener el sistema actualizado para asegurar la seguridad y el rendimiento óptimo. Los comandos `sudo apt update` y `sudo apt upgrade` actualizan la lista de paquetes y luego instalan las últimas versiones disponibles.

```bash
sudo apt update
sudo apt upgrade
```

### 2. Instalación de GIT

Git es un sistema de control de versiones distribuido esencial para la gestión del código fuente. Instálalo y verifica su versión para confirmar que la instalación fue exitosa.

```bash
sudo apt install git
git --version
```

### 3. Configuración Básica de Git (Opcional)

Configura tu identidad en Git. Esto es importante porque cada commit en Git usa esta información:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

### 4. Instalación de Java

Java es necesario para ejecutar aplicaciones Java, como Spring Boot. Aquí instalamos la versión 17.

```bash
sudo apt install openjdk-17-jdk
java -version
```

### 5. Instalación de Python

Python es un lenguaje de programación versátil, necesario para FastAPI. Instalamos la versión 3.11.

```bash
sudo apt install python3.11
python3.11 --version
```

### 6. Configuración de Entorno Virtual

Los entornos virtuales en Python son útiles para manejar dependencias de proyectos de manera aislada.

```bash
sudo apt install python3-pip
pip3 install virtualenv
```

## Instalación de Proyectos

### Proyecto Connector de Base de Datos

#### 1. Descarga del Proyecto

Clona el repositorio y accede al directorio del proyecto.

```bash
git clone https://github.com/diegocondo10/IbmInformixDbConnector.git
cd IbmInformixDbConnector
```

#### 2. Empaquetado de la Aplicación

Empaqueta la aplicación con Maven, asegurándote de que tienes permisos de ejecución en el script `mvnw`.

```bash
chmod +x mvnw
./mvnw clean package
```

#### 3. Creación de un Servicio de Sistema

Configura un servicio de systemd para ejecutar el conector en segundo plano.

3.1 Crea el archivo de servicio con nano:

```bash
sudo nano /etc/systemd/system/dbconnector.service
```

3.2 Añade el siguiente contenido, ajustando la ruta al JAR:

```ini
[Unit]
Description=DbConnector
After=syslog.target

[Service]
User=root
ExecStart=/usr/bin/java -jar /path-to/DbConnector.jar
Restart=always

[Install]
WantedBy=multi-user.target
```

#### 4. Recargar y Habilitar el Servicio

Recarga systemd y habilita el servicio para que se inicie en el arranque.

```bash
sudo systemctl daemon-reload
sudo systemctl enable dbconnector.service
sudo systemctl start dbconnector.service
```

#### 5. Verificación del Servicio

Comprueba el estado del servicio para asegurarte de que se está ejecutando correctamente.

```bash
sudo systemctl status dbconnector.service
```

#### 6. Configuración del Firewall

Asegúrate de que el puerto utilizado por tu conector esté abierto en el firewall.

```bash
sudo ufw allow 5690
```

## Configuración de FastAPI

### 1. Clonación del Proyecto

Clona el repositorio de FastAPI y verifica la instalación de Python y el entorno virtual como se describió anteriormente.

### 2. Creación y Activación del Entorno Virtual

Establece un entorno virtual para manejar las dependencias de FastAPI.

```bash
python3.11 -m venv venv
source venv/bin/activate
```

### 3. Instalación de Dependencias

Instala las dependencias necesarias para el proyecto FastAPI desde el archivo `requirements.txt`.

```bash
pip install -r requirements.txt
```

### 4. Creación de un Servicio de Sistema para FastAPI

Configura un servicio de systemd para ejecutar FastAPI en segundo plano.

4.1 Crea el archivo de servicio:

```bash
sudo nano /etc/systemd/system/fastapi.service
```

4.2 Añade el siguiente contenido, ajustando las rutas según sea necesario:

```ini
[Unit]
Description=FastAPI Asisken
After=network.target

[Service]
User=root
Group=www-data
WorkingDirectory=/home/asisken/fast-api-with-ibm-informix-demo
Environment="PATH=/home/asisken/fast-api-with-ibm-informix-demo/venv/bin"
ExecStart=/home/asisken/fast-api-with-ibm-informix-demo/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000

[Install]
WantedBy=multi-user.target
```

### 5. Habilitación y Verificación del Servicio FastAPI

Habilita, inicia y verifica el servicio FastAPI.

```bash
sudo systemctl daemon-reload
sudo systemctl start fastapi.service
sudo systemctl enable fastapi.service
sudo systemctl status fastapi.service
```

---

Esta versión mejorada de tu guía incluye explicaciones más detalladas y mejores prácticas para cada paso, lo que debería hacerla más útil y comprensible para tu cliente.

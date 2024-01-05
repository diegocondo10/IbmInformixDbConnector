# Preparacion inicial del servidor:

1. Actualizacion de dependencias
   ```
   sudo apt update
   sudo apt upgrade
   ```
2. Instalación de GIT
   ```
   sudo apt install git
   git --version
   ```
3. **Configuración Básica (Opcional)**: Después de instalar Git, es recomendable configurar tu nombre de usuario y dirección de correo electrónico, ya que Git los utiliza en tus commits. Puedes hacerlo con los siguientes comandos:
   ```
   git config --global user.name "Tu Nombre"
   git config --global user.email "tuemail@example.com"
   ```
4. Instalacion de Java:
   ```
   sudo apt install openjdk-17-jdk
   java -version
   ```
5. Instalacion de Python
   ```
   sudo apt install python3.11
   python3.11 --version
   ```
6. Configuración de entorno virtual
   ```
   sudo apt install python3-pip
   pip3 install virtualenv
   ```
7. Instalacion de Nginx
   ```
   sudo apt install nginx
   ```

# Instalacion de Proyectos

#### Proyecto Connector de base de datos
1. Descargamos el proyecto usando Git e ingresamos al directorio:
    ```
    git clone https://github.com/diegocondo10/IbmInformixDbConnector.git
    cd IbmInformixDbConnector
    ```
2. Empaquetamos la aplicacion
    ```
    chmod +x mvnw
    ./mvnw clean package
    ```
3. Creamos un usuario para ejecutar la aplicacion
    ```
    sudo adduser springbootapp
    sudo su - springbootapp
    ```
4. Configuramos el servicio en nuestro sistema copiando el archivo springbootapp.service
    ```
    sudo mv springbootapp.service /etc/systemd/system/
    ```












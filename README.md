### **README.md**

# Prueba Técnica: Proyecto de Infraestructura AWS con Terraform

Este proyecto está diseñado como parte de una prueba técnica para evaluar habilidades relacionadas con la configuración y gestión de infraestructura en AWS utilizando Terraform. Aquí encontrarás los módulos necesarios para desplegar una infraestructura básica y scripts adicionales para configurar y probar los recursos.

---

## **Estructura del Proyecto**

El proyecto está organizado en los siguientes directorios:

- **`modules/`**: Contiene los módulos reutilizables de Terraform:
  - `network`: Configuración de la red (VPC, subnets, NACLs, tablas de rutas, grupos de seguridad, etc.).
  - `s3`: Configuración de un bucket S3 para almacenamiento.
  - `iam`: Configuración de roles y políticas para las instancias EC2.
  - `ec2`: Configuración de las instancias EC2.
- **`environments/testing/`**: Configuración del entorno de prueba con variables específicas para `testing`.
- **`scripts/`**: Contiene los scripts que se ejecutan en las instancias EC2, como `setup.sh` y `monitor.sh`.

---

## **Requisitos Previos**

Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas:
- [Terraform](https://www.terraform.io/downloads)
- Una cuenta de AWS con permisos para crear recursos (VPC, EC2, S3, IAM, etc.)
- [AWS CLI](https://aws.amazon.com/cli/) configurado con tus credenciales.
- Un par de claves SSH configurado para acceder a las instancias EC2.

---

## **Instrucciones de Uso**

### **1. Configurar Variables**
Edita el archivo `environments/testing/terraform.tfvars` para personalizar las variables según tu entorno:
```hcl
# General variables
app_name    = "<nombre-aplicación>"
environment = "<entorno>"
region      = "us-east-2"

# Network variables
ip_address_prefix = "192.168.0"
dev_ip_address    = "<your-ip>/32"

# EC2 variables
instance_type        = "t2.micro"
ami_id               = "ami-00eb69d236edcfaf8"
key_pair             = "<your-key-pair>"
script_name          = "setup.sh"
instance_name        = "<nombre-instancia>"
```

Asegúrate de reemplazar `<your-ip>` y `<your-key-pair>` con tu dirección IP pública y tu par de claves SSH configurado en AWS, respectivamente.

### **2. Inicializar y Validar Terraform**
Navega al directorio del entorno:
```bash
cd environments/testing
terraform init
terraform validate
```

### **3. Desplegar la Infraestructura**
Ejecuta los siguientes comandos para aplicar los cambios y desplegar la infraestructura:
```bash
terraform plan
terraform apply
```
Confirma los cambios cuando se solicite.

---

## **Componentes de la Infraestructura**

1. **Red (Network)**:
   - VPC con subnets públicas y privadas.
   - Tablas de rutas y asociaciones.
   - NACLs configurados para controlar tráfico entrante y saliente.

2. **Instancia EC2**:
   - Instancia `t2.micro`.
   - Security Group que permite tráfico HTTPS (`443`) y SSH (`22`).
   - User Data que escribe los scripts de configuración (`setup.sh` y `monitor.sh`) en `/tmp`.

3. **Bucket S3**:
   - Bucket configurado para almacenar logs desde la instancia EC2.

4. **IAM**:
   - Role asociado a la instancia con permisos para acceder al bucket S3.
   - Policy adicional para gestionar logs.

---

## **Pruebas de Funcionamiento**

### **1. Resolver Problemas de Networking**
Una vez desplegada la infraestructura, verifica que puedes acceder a la instancia EC2 vía SSH:
```bash
ssh -i <ruta-a-tu-clave-privada.pem> ubuntu@<public-ip>
```
Es posible que encuentres problemas de conectividad relacionados con la red. El objetivo es identificar y resolver estos problemas para garantizar que la instancia sea accesible.

---

### **2. Configurar el Proyecto**
Una vez dentro de la instancia EC2, ejecuta el script de configuración:
```bash
sudo /tmp/setup.sh
```
Este script instalará las dependencias necesarias (como Nginx y AWS CLI) y configurará el entorno.

---

### **3. Probar la Conectividad del Servidor Web**
1. Intenta acceder a la página de inicio de Nginx desde un navegador:
   ```bash
   http://<public-ip>
   ```
2. Si no puedes acceder, valida que Nginx está corriendo localmente:
   ```bash
   curl -i localhost:80
   ```
   Si este comando muestra la página de inicio de Nginx, significa que el servidor está funcionando localmente, pero podría haber problemas con la configuración de red o de seguridad que impidan exponerlo a Internet.

---

### **4. Probar el Acceso a S3**
1. Crea un archivo de prueba en la instancia EC2:
   ```bash
   echo "Hello from EC2!" > /tmp/test-file.txt
   ```
2. Sube el archivo al bucket S3:
   ```bash
   aws s3 cp /tmp/test-file.txt s3://<bucket-name>/
   ```
3. Verifica que el archivo se ha subido correctamente:
   ```bash
   aws s3 ls s3://<bucket-name>/
   ```
Durante este proceso podrían surgir errores relacionados con permisos o configuración. La idea es diagnosticar y resolver estos problemas.

---

### **5. Implementar la Automatización para Logs**
Una vez que hayas validado la conectividad y el acceso a S3, crea un script para automatizar el envío de logs desde la instancia EC2 al bucket S3 como se sugiere en la práctica.

---

### **6. Escenario de Monitoreo**
Con el script `/tmp/monitor.sh`, simula una carga alta en la instancia y recolecta métricas clave del sistema (CPU, memoria, disco, etc.). Para ejecutarlo:
```bash
sudo /tmp/monitor.sh
```
Evalúa el comportamiento del sistema bajo estrés y usa estas métricas para diseñar un sistema de monitoreo con alertas como se sugiere en la práctica.

---

## **Limpieza de Recursos**

No elimines la infraestructura hasta que esta haya sido revisada en la sustentación. Una vez revisada, puedes proceder a eliminar los recursos creados:
```bash
terraform destroy
```
Confirma cuando se te solicite.

---

## **Notas Importantes**

- Este proyecto puede contener varios problemas de configuración, como errores en la red o permisos en los roles de IAM. El objetivo es identificar y solucionar estos problemas.
- Los scripts creados en `/tmp` están configurados para ejecutarse manualmente, pero puedes adaptarlos para que sean programados (por ejemplo, con `cron`).

---

## **Contribuciones**

Este proyecto es parte de una prueba técnica y no está diseñado para producción. Si tienes sugerencias o encuentras errores, comunícalo al evaluador.

---

## **Contacto**
Para cualquier duda o aclaración sobre esta prueba, puedes ponerte en contacto con el evaluador asignado.

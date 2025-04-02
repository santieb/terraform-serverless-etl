# 🚀 TERRAFORM-SERVERLESS-ETL

Este repositorio contiene una arquitectura serverless, modular y escalable para proyectos de ETL/ELT sobre AWS. Fue diseñada para ser fácilmente reutilizable en distintos proyectos de procesamiento de datos.

---

## 📦 Componentes principales

- **AWS Lambda**: Extrae datos desde una fuente externa (API, etc.)
- **API Gateway**: Dispara la Lambda vía POST
- **S3 (Data Lake)**:
  - `raw/`: datos originales
  - `processed/`: datos transformados o listos para consulta
- **Glue Crawler**: Analiza los archivos en S3
- **Glue Catalog Database**: Registra el esquema de las tablas
- **Athena**: Permite consultas SQL sobre los datos
- **Secrets Manager**: Almacena tokens o credenciales sensibles
---

## 🧱 Estructura del repositorio

```
terraform-serverless-etl/
├── main.tf                  # Orquesta todos los módulos
├── variables.tf             # Variables globales
├── outputs.tf               # Valores de salida
├── locals.tf                # Tags comunes y valores derivados
├── provider.tf              # Configuración AWS
├── .gitignore
├── modules/
│   ├── lambda/
│   ├── apigateway/
│   ├── storage/
│   ├── crawler/
│   └── data_catalog/
```

---

## 🧠 Arquitectura del proyecto

Este proyecto implementa una arquitectura **serverless** en AWS para extraer datos de reportes de Mercado Pago, almacenarlos en un data lake y habilitar su consulta analítica. La arquitectura sigue un enfoque modular, con separación entre extracción, almacenamiento y consulta.

### 🔐 Entrada y disparo

- **API Gateway** expone un endpoint HTTP `POST` que activa el proceso.
- La autenticación del token de Mercado Pago se gestiona a través de **Secrets Manager**, evitando exponer credenciales en el código.

### ⚙️ Procesamiento

- Una función **AWS Lambda** realiza lo siguiente:
  - Consulta la API de Mercado Pago.
  - Descarga el último reporte disponible en formato CSV.
  - Lo guarda en dos ubicaciones del bucket de S3:
    - `/raw/`: copia sin transformar.
    - `/processed/`: copia destinada al análisis (opcionalmente convertida a Parquet).
  - Lanza un **Glue Crawler** para actualizar el catálogo de datos.

### 🗃️ Almacenamiento

- Un único bucket de **Amazon S3** actúa como data lake, estructurado por carpetas:
  - `raw/`: datos originales sin procesar.
  - `processed/`: datos listos para análisis.

### 🧹 Catalogación y consulta

- **Glue Crawler** detecta el esquema de los archivos en `/processed/` y actualiza una base de datos del **Glue Data Catalog**.
- Luego, **Amazon Athena** puede consultar estos datos usando SQL estándar.

## ⚙️ Despliegue

```bash
terraform init
terraform apply
```

> ⚠️ Asegurate de configurar previamente el Secret en AWS Secrets Manager con tu token de acceso a la API.

---

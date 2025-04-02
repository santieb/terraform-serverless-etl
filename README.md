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

## 🌐 Arquitectura general

```mermaid
flowchart TD
  %% Estilo común
  classDef aws fill:#ffffff,stroke:#d1d5db,color:#111827,font-size:14px,font-family:sans-serif,rx:6,ry:6;

  %% Secciones lógicas
  subgraph Entrada["🔐 Entrada"]
    API["🟪 API Gateway"]
  end

  subgraph Procesamiento["⚙️ Procesamiento"]
    LAMBDA["🟨 Lambda"]
  end

  subgraph Almacenamiento["📦 Almacenamiento"]
    RAW["🟦 S3 Bucket raw"]
    PROCESSED["🟦 S3 Bucket processed"]
  end

  subgraph Catálogo["🧠 Catálogo y Consulta"]
    CRAWLER["🟪 Glue Crawler Detecta esquema"]
    GLUE["📚 Glue Catalog DB"]
    ATHENA["🟦 Athena SQL queries"]
  end

  %% Flujo
  API --> LAMBDA
  LAMBDA --> RAW
  LAMBDA --> PROCESSED
  PROCESSED --> CRAWLER
  CRAWLER --> GLUE
  GLUE --> ATHENA

  %% Estética
  class API,LAMBDA,RAW,PROCESSED,CRAWLER,GLUE,ATHENA aws;
```

---

## ⚙️ Despliegue

```bash
terraform init
terraform apply
```

> ⚠️ Asegurate de configurar previamente el Secret en AWS Secrets Manager con tu token de acceso a la API.


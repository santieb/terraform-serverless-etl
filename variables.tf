variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "env" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "mp-transactions-etl"
}

variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
  default     = "handler.handler"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  type        = string
  default     = "python3.11"
}

variable "output_bucket_name" {
  description = "Name of the output S3 bucket"
  type        = string
  default     = "sbarreto-bucket"
}

variable "lambda_zip_path" {
  description = "Path to the Lambda deployment package zip"
  type        = string
  default     = "../build/mp_transactions_etl.zip"
}

variable "lambda_function_name" {}
variable "lambda_handler" {}
variable "lambda_runtime" {}
variable "lambda_zip_path" {}
variable "aws_region" {}
variable "secret_name" {}
variable "output_bucket_name" {}
variable "common_tags" {
  type = map(string)
}
variable "account_id" {}
variable "output_bucket_arn" {}
variable "crawler_name" {}

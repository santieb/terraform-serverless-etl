variable "lambda_invoke_arn" {}
variable "lambda_name" {}
variable "env" {}
variable "aws_region" {}
variable "common_tags" {
  type = map(string)
}

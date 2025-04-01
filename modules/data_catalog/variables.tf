variable "crawler_name" {}
variable "glue_database_name" {}
variable "s3_target_path" {}
variable "query_results_bucket" {}
variable "role_arn" {}
variable "common_tags" {
  type = map(string)
}
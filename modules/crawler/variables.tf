variable "crawler_name" {}
variable "glue_database_name" {}
variable "s3_target_path" {}
variable "common_tags" {
  type = map(string)
}
variable "role_arn" {}
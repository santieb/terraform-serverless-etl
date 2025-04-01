output "glue_database_name" {
  value = aws_glue_catalog_database.this.name
}

output "crawler_name" {
  value = aws_glue_crawler.this.name
}

output "athena_workgroup_name" {
  value = aws_athena_workgroup.this.name
}
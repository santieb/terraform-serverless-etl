output "crawler_name" {
  value = aws_glue_crawler.this.name
}

output "glue_database_name" {
  value = aws_glue_catalog_database.this.name
} 
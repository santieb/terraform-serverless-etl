resource "aws_glue_catalog_database" "this" {
  name = var.glue_database_name
  tags = var.common_tags
}

resource "aws_glue_crawler" "this" {
  name          = var.crawler_name
  role          = var.role_arn
  database_name = aws_glue_catalog_database.this.name

  s3_target {
    path = var.s3_target_path
  }

  schedule = null

  tags = var.common_tags
}

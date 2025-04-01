resource "aws_glue_catalog_database" "this" {
  name = var.glue_database_name
  tags = var.common_tags
}

resource "aws_iam_role" "glue_crawler_role" {
  name = "glue-crawler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy" "glue_crawler_policy" {
  name = "glue-crawler-policy"
  role = aws_iam_role.glue_crawler_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "glue:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_glue_crawler" "this" {
  name          = var.crawler_name
  role          = aws_iam_role.glue_crawler_role.arn
  database_name = aws_glue_catalog_database.this.name

  s3_target {
    path = var.s3_target_path
  }

  tags = var.common_tags
}

resource "aws_athena_workgroup" "this" {
  name = "mp_transactions_workgroup"

  configuration {
    enforce_workgroup_configuration = true
    result_configuration {
      output_location = "s3://${var.query_results_bucket}/athena-results/"
    }
  }

  tags = var.common_tags
}

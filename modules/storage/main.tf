data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "mp_transactions_output_bucket" {
  bucket = var.output_bucket_name
  tags   = var.common_tags
}

output "output_bucket_name" {
  description = "Name of the output S3 bucket"
  value       = aws_s3_bucket.mp_transactions_output_bucket.bucket
}

output "output_bucket_arn" {
  description = "ARN of the output S3 bucket"
  value       = aws_s3_bucket.mp_transactions_output_bucket.arn
}

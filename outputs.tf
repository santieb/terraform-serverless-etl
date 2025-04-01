output "lambda_function_name" {
  value       = module.lambda.lambda_function_name
  description = "Name of the Lambda function"
}

output "lambda_function_arn" {
  value       = module.lambda.lambda_function_arn
  description = "ARN of the Lambda function"
}

output "output_bucket_name" {
  value       = module.storage.output_bucket_name
  description = "Name of the output bucket"
}

output "output_bucket_arn" {
  value       = module.storage.output_bucket_arn
  description = "ARN of the output bucket"
}

output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = aws_lambda_function.mp_transactions_etl_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = aws_lambda_function.mp_transactions_etl_lambda.arn
}

output "lambda_invoke_arn" {
  description = "Invoke ARN for integration with API Gateway"
  value       = aws_lambda_function.mp_transactions_etl_lambda.invoke_arn
}

output "lambda_exec_role_arn" {
  value = aws_iam_role.mp_transactions_lambda_exec_role.arn
} 
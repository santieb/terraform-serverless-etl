output "api_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.mp_transactions_api.id}.execute-api.${var.aws_region}.amazonaws.com/${var.env}/transactions"
}

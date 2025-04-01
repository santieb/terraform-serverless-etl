resource "aws_api_gateway_rest_api" "mp_transactions_api" {
  name        = "mp-transactions-api"
  description = "API for Mercado Pago transaction ETL"
  tags        = var.common_tags
}

resource "aws_api_gateway_resource" "transactions_resource" {
  rest_api_id = aws_api_gateway_rest_api.mp_transactions_api.id
  parent_id   = aws_api_gateway_rest_api.mp_transactions_api.root_resource_id
  path_part   = "transactions"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.mp_transactions_api.id
  resource_id   = aws_api_gateway_resource.transactions_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.mp_transactions_api.id
  resource_id             = aws_api_gateway_resource.transactions_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.mp_transactions_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.mp_transactions_api.id
}

resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = var.env
  rest_api_id   = aws_api_gateway_rest_api.mp_transactions_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  tags          = var.common_tags
}

resource "aws_iam_role" "mp_transactions_lambda_exec_role" {
  name = "${var.lambda_function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy" "mp_transactions_lambda_policy" {
  name = "${var.lambda_function_name}-s3-write-policy"
  role = aws_iam_role.mp_transactions_lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = "${var.output_bucket_arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "mp_transactions_lambda_secret_policy" {
  name = "${var.lambda_function_name}-secrets-policy"
  role = aws_iam_role.mp_transactions_lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:${var.secret_name}*"
      }
    ]
  })
}

resource "aws_lambda_function" "mp_transactions_etl_lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.mp_transactions_lambda_exec_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      OUTPUT_BUCKET  = var.output_bucket_name
      MP_SECRET_NAME = var.secret_name
      CRAWLER_NAME   = var.crawler_name
    }
  }

  tags = var.common_tags
}

resource "aws_iam_role_policy" "mp_transactions_lambda_glue_policy" {
  name = "${var.lambda_function_name}-glue-crawler-policy"
  role = aws_iam_role.mp_transactions_lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "glue:StartCrawler"
        ],
        Resource = "arn:aws:glue:${var.aws_region}:${var.account_id}:crawler/${var.crawler_name}"
      }
    ]
  })
}

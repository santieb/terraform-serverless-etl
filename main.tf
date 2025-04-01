data "aws_caller_identity" "current" {}

module "storage" {
  source             = "./modules/storage"
  output_bucket_name = var.output_bucket_name
  common_tags        = local.common_tags
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  lambda_handler       = var.lambda_handler
  lambda_runtime       = var.lambda_runtime
  lambda_zip_path      = var.lambda_zip_path
  aws_region           = var.aws_region
  secret_name          = local.secret_name
  output_bucket_name   = module.storage.output_bucket_name
  output_bucket_arn    = module.storage.output_bucket_arn
  common_tags          = local.common_tags
  account_id           = data.aws_caller_identity.current.account_id
  crawler_name         = module.data_catalog.crawler_name
}

module "apigateway" {
  source            = "./modules/apigateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  lambda_name       = module.lambda.lambda_function_name
  env               = var.env
  aws_region        = var.aws_region
  common_tags       = local.common_tags
}

module "data_catalog" {
  source               = "./modules/data_catalog"
  crawler_name         = "mp-transactions-crawler"
  glue_database_name   = "mp_transactions_db"
  s3_target_path       = "s3://${module.storage.output_bucket_name}/processed/"
  query_results_bucket = module.storage.output_bucket_name
  role_arn             = module.lambda.lambda_exec_role_arn
  common_tags          = local.common_tags
}
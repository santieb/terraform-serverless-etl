locals {
  secret_name = "mercadopago_access_token_${var.env}"

  common_tags = {
    env        = var.env
    owner      = "sbarreto"
    app        = "mercadopago"
    managed_by = "terraform"
  }
}

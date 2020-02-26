locals {
  role_account_id      = var.role_account_id == "" ? data.aws_caller_identity.current.account_id : var.role_account_id
  role_arn             = "arn:aws:iam::${local.role_account_id}:role/${var.role_name}"
  terraform_version    = "0.12.21"
  terraform_state_file = "terraform.tfstate"
  terraform_backend_config_file = format(
    "%s/%s",
    var.terraform_backend_config_file_path,
    var.terraform_backend_config_file_name
  )
}

data "aws_caller_identity" "current" {}

module "this" {
  source                        = "git@github.com:cloudposse/terraform-aws-tfstate-backend?ref=tags/0.13.0"
  namespace                     = var.name
  stage                         = var.environment
  name                          = "terraform"
  attributes                    = ["state"]
  region                        = var.region
  tags                          = var.tags
  block_public_acls             = true
  block_public_policy           = true
  restrict_public_buckets       = true
  ignore_public_acls            = true
  read_capacity                 = var.read_capacity
  write_capacity                = var.write_capacity
  enable_server_side_encryption = true
  profile                       = ""
  role_arn                      = local.role_arn
  terraform_version             = local.terraform_version
  terraform_state_file          = local.terraform_state_file
}

data "template_file" "terraform_backend_config" {
  template = file("${path.module}/templates/terraform.tf.tpl")

  vars = {
    region               = var.region
    encrypt              = true
    bucket               = module.this.s3_bucket_id
    dynamodb_table       = module.this.dynamodb_table_name
    role_arn             = local.role_arn
    terraform_version    = local.terraform_version
    terraform_state_file = local.terraform_state_file
  }
}

resource "local_file" "terraform_backend_config" {
  count    = var.terraform_backend_config_file_path != "" ? 1 : 0
  content  = data.template_file.terraform_backend_config.rendered
  filename = local.terraform_backend_config_file
}

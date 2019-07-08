module "this" {
  source                        = "git@github.com:cloudposse/terraform-aws-tfstate-backend?ref=0.9.0"
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
}


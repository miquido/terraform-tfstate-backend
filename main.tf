module "this" {
  source              = "git@github.com:cloudposse/terraform-aws-tfstate-backend?ref=0.7.0"
  namespace           = "${var.name}"
  stage               = "${var.environment}"
  name                = "terraform"
  attributes          = ["state"]
  region              = "${var.region}"
  tags                = "${var.tags}"
  block_public_acls   = "true"
  block_public_policy = "true"
}

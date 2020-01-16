provider "aws" {
  region = "us-east-1"
}

module "tfstate-backend" {
  source = "../../"
  name   = "test"
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-1"
}

module "tfstate-backend" {
  source                             = "../../"
  name                               = "test"
  terraform_backend_config_file_path = path.module
}

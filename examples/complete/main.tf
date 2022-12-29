provider "aws" {
  region = "us-east-1"
}

module "task" {

  source          = "../.."
  cluster_arn     = "test"
  task_cpu        = 0
  container_image = "test"
  task_memory     = 0
  container_tag   = "test"
  environment     = "test"
  name            = "test"
  project         = "test"
  region          = "test"
  security_groups = []
  subnets         = []
}

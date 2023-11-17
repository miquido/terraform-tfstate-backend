terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.26"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.3"
    }
  }
}

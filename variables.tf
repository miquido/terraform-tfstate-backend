variable "environment" {
  default     = ""
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Account/Project Name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply on repository"
}

variable "region" {
  type        = string
  description = "AWS Region the S3 bucket should reside in"
}

variable "role_account_id" {
  type        = string
  default     = ""
  description = "The AWS Account ID of IAM Role to be assumed. If none provided current caller account id will be used."
}

variable "role_name" {
  type        = string
  default     = "AdministratorAccess"
  description = "The IAM Role name to be assumed"
}

variable "read_capacity" {
  default     = 1
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  default     = 1
  description = "DynamoDB write capacity units"
}

variable "terraform_backend_config_file_name" {
  type        = string
  default     = "tfstate-backend.tf"
  description = "Name of terraform backend config file"
}

variable "terraform_backend_config_file_path" {
  type        = string
  default     = ""
  description = "The path to terrafrom project directory. Won't create local file if variable value is empty. Recommended: `path.module`"
}

variable "billing_mode" {
  default     = "PAY_PER_REQUEST"
  description = "DynamoDB billing mode"
}

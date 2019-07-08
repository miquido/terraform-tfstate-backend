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

variable "read_capacity" {
  default     = 1
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  default     = 1
  description = "DynamoDB write capacity units"
}

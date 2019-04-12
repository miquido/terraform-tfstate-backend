variable "environment" {
  default     = ""
  description = "(Optional) Environment name"
}

variable "name" {
  type        = "string"
  description = "(Required) Account/Project Name"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "(Optional) Tags to apply on repository"
}

variable "region" {
  type        = "string"
  description = "(Required) AWS Region to create resources on"
}

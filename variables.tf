variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "container_image" {
  type = string
}

variable "container_tag" {
  type = string
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "cluster_arn" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "log_configuration" {
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })

  description = "Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"

  default = null
}

variable "log_retention" {
  default     = 7
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Option has no effect when custom \"log_configuration\" variable is specified."
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = number
}

variable "container_cmd" {
  type        = list(string)
  default     = null
  description = "Command that will be run on the task"
}

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables passed to container"

  default = []
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))

  description = "The secrets to pass to the container. This is a list of maps"

  default = []
}
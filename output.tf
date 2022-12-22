output "task_definition_arn" {
  value = local.task_definition_arn_only
}

output "task_definition" {
  value = local.family
}

output "container_name" {
  value = module.label.id
}

output "service_role_arn" {
  value = aws_iam_role.service_role.arn
}

output "execution_role_arn" {
  value = aws_iam_role.execution_role.arn
}

output "service_role_id" {
  value = aws_iam_role.service_role.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.ecs-cron.arn
}

output "service_role_arn" {
  value = aws_iam_role.service_role.arn
}

output "execution_role_arn" {
  value = aws_iam_role.execution_role.arn
}
module "label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label?ref=tags/0.5.1"
  name      = var.name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags
}

locals {
  task_definition_arn_only = replace(aws_ecs_task_definition.ecs-cron.arn, "/:\\d+$/", "")
}

locals {
  use_default_log_config     = var.log_configuration == null
  container_definitions      = compact(concat(list(module.container.json_map_encoded)))
  container_definitions_json = "[${join(",", local.container_definitions)}]"
  default_log_configuration_secrets = length(var.secrets) > 0 ? [
    for key in var.secrets :
    {
      name      = "${lookup(key, "name")}_SECRET"
      valueFrom = lookup(key, "valueFrom")
    }
  ] : var.secrets
  ssms = var.secrets.*.valueFrom
}

module "container" {
  source           = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition?ref=tags/0.46.2"
  container_name   = module.label.id
  container_image  = "${var.container_image}:${var.container_tag}"
  container_cpu    = var.container_cpu
  container_memory = var.container_memory
  command          = var.container_cmd

  secrets = var.secrets

  log_configuration = local.use_default_log_config ? {
    logDriver     = "awslogs"
    secretOptions = local.default_log_configuration_secrets
    options = {
      awslogs-region        = var.region
      awslogs-group         = join("", aws_cloudwatch_log_group.app.*.name)
      awslogs-stream-prefix = var.name
    }
  } : var.log_configuration

  environment = var.environment_variables
}

resource "aws_ecs_task_definition" "ecs-cron" {
  family                   = "${module.label.id}-ecs"
  network_mode             = "awsvpc"
  container_definitions    = local.container_definitions_json
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  task_role_arn            = aws_iam_role.service_role.arn
  execution_role_arn       = aws_iam_role.execution_role.arn
}

resource "aws_iam_role" "service_role" {
  name               = "${module.label.id}-service-role"
  assume_role_policy = data.aws_iam_policy_document.service_role.json
}

data "aws_iam_policy_document" "service_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "execution-policy" {
  name = "${module.label.id}-execution-policy"
  role = aws_iam_role.execution_role.id

  policy = data.aws_iam_policy_document.execution-policy.json
}

data "aws_iam_policy_document" "ecs-exec-ssm-secrets" {

  statement {
    effect    = "Allow"
    resources = local.ssms
    actions   = ["ssm:GetParameters"]
  }
}

resource "aws_iam_role_policy" "ecs-exec-ssm-secrets" {
  count  = length(local.ssms) > 0 ? 1 : 0
  name   = "${module.label.id}-ssm-secrets"
  policy = data.aws_iam_policy_document.ecs-exec-ssm-secrets.json
  role   = aws_iam_role.execution_role.id
}

data "aws_iam_policy_document" "execution-policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_cloudwatch_log_group" "app" {
  count             = local.use_default_log_config ? 1 : 0
  name              = "/aws/ecs/${module.label.id}"
  tags              = module.label.tags
  retention_in_days = var.log_retention
}

resource "aws_iam_role" "execution_role" {
  name               = "${module.label.id}-ex-role"
  assume_role_policy = data.aws_iam_policy_document.execution_role.json
}

data "aws_iam_policy_document" "execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_event_rule" "scheduled_task" {
  name                = "${module.label.id}-scheduled_task"
  schedule_expression = var.schedule_expression
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "scheduled_task" {
  target_id = "${module.label.id}-target"
  rule      = aws_cloudwatch_event_rule.scheduled_task.name
  arn       = var.cluster_arn
  role_arn  = aws_iam_role.scheduled_task_cloudwatch.arn

  ecs_target {

    launch_type         = "FARGATE"
    task_count          = "1"
    task_definition_arn = local.task_definition_arn_only
    platform_version    = "1.4.0"

    network_configuration {
      subnets          = var.subnets
      assign_public_ip = var.assign_public_ip
      security_groups  = var.security_groups
    }
  }
}

resource "aws_iam_role" "scheduled_task_cloudwatch" {
  name               = "${module.label.id}-st-cloudwatch-role"
  assume_role_policy = data.aws_iam_policy_document.scheduled_task_cloudwatch.json
}

data "aws_iam_policy_document" "scheduled_task_cloudwatch" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "scheduled_task_cloudwatch_policy" {
  name   = "${module.label.id}-run-ecs-task-policy"
  role   = aws_iam_role.scheduled_task_cloudwatch.id
  policy = data.aws_iam_policy_document.scheduled_task_cloudwatch-m.json
}

data "aws_iam_policy_document" "scheduled_task_cloudwatch-m" {
  statement {
    actions   = ["ecs:RunTask"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["iam:PassRole"]
    effect    = "Allow"
    resources = ["*"]
    condition {
      test     = "StringLike"
      values   = ["ecs-tasks.amazonaws.com"]
      variable = "iam:PassedToService"
    }
  }
}

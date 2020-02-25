## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | Environment name | string | `` | no |
| name | Account/Project Name | string | - | yes |
| read_capacity | DynamoDB read capacity units | string | `1` | no |
| region | AWS Region the S3 bucket should reside in | string | - | yes |
| role_account_id | The AWS Account ID of IAM Role to be assumed. If none provided current caller account id will be used. | string | `` | no |
| role_name | The IAM Role name to be assumed | string | `AdministratorAccess` | no |
| tags | Tags to apply on repository | map(string) | `<map>` | no |
| terraform_backend_config_file_name | Name of terraform backend config file | string | `tfstate-backend.tf` | no |
| terraform_backend_config_file_path | The path to terrafrom project directory. Won't create local file if variable value is empty. Recommended: `path.module` | string | `` | no |
| write_capacity | DynamoDB write capacity units | string | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb_table_arn | The ARN of created DynamoDB Table |
| dynamodb_table_id | The ID of created DynamoDB Table |
| dynamodb_table_name | The name of created DynamoDB Table |
| s3_bucket_arn | S3 bucket ARN |
| s3_bucket_domain_name | S3 bucket domain name |
| s3_bucket_id | S3 bucket ID |
| tf_backend_config | Rendered Terraform backend config file |


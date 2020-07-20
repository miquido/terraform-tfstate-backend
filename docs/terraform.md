## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_mode | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| environment | Environment name | `string` | `""` | no |
| name | Account/Project Name | `string` | n/a | yes |
| read\_capacity | DynamoDB read capacity units | `number` | `1` | no |
| region | AWS Region the S3 bucket should reside in | `string` | n/a | yes |
| role\_account\_id | The AWS Account ID of IAM Role to be assumed. If none provided current caller account id will be used. | `string` | `""` | no |
| role\_name | The IAM Role name to be assumed | `string` | `"AdministratorAccess"` | no |
| tags | Tags to apply on repository | `map(string)` | `{}` | no |
| terraform\_backend\_config\_file\_name | Name of terraform backend config file | `string` | `"tfstate-backend.tf"` | no |
| terraform\_backend\_config\_file\_path | The path to terrafrom project directory. Won't create local file if variable value is empty. Recommended: `path.module` | `string` | `""` | no |
| write\_capacity | DynamoDB write capacity units | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb\_table\_arn | The ARN of created DynamoDB Table |
| dynamodb\_table\_id | The ID of created DynamoDB Table |
| dynamodb\_table\_name | The name of created DynamoDB Table |
| s3\_bucket\_arn | S3 bucket ARN |
| s3\_bucket\_domain\_name | S3 bucket domain name |
| s3\_bucket\_id | S3 bucket ID |
| tf\_backend\_config | Rendered Terraform backend config file |


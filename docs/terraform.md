## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | Environment name | string | `` | no |
| name | Account/Project Name | string | - | yes |
| read_capacity | DynamoDB read capacity units | string | `1` | no |
| region | AWS Region to create resources on | string | - | yes |
| tags | Tags to apply on repository | map | `<map>` | no |
| write_capacity | DynamoDB write capacity units | string | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb_table_name | Name of created DynamoDB Table |
| s3_bucket_name | Name of created S3 Bucket |
| tf_backend_config | Rendered backend config file |


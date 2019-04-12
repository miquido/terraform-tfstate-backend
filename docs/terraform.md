## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | (Optional) Environment name | string | `` | no |
| name | (Required) Account/Project Name | string | - | yes |
| region | (Required) AWS Region to create resources on | string | - | yes |
| tags | (Optional) Tags to apply on repository | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb_table_name | Name of created DynamoDB Table |
| s3_bucket_name | Name of created S3 Bucket |
| tf_backend_config | Rendered backend config file |


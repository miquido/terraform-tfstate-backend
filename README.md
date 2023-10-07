<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# terraform-tfstate-backend
Terraform module to provision S3 Bucket for Terraform State Backend and DynamoDB Table for state locking.

### Open source modules used:
* https://github.com/cloudposse/terraform-aws-tfstate-backend
---
**Terraform Module**


GitLab Repository: https://gitlab.com/miquido/terraform/terraform-tfstate-backend

## Usage

1. Use module to create bucket

    ```
    terraform {}

    module "tfstate-backend" {
        source      = "git::ssh://git@gitlab.com:miquido/terraform/terraform-tfstate-backend.git?ref=master"
        name        = "miquido"
        environment = "devops"
    }

    output "config" {
        value = "${module.tfstate-backend.tf_backend_config}"
    }
    ```

2. Run commands

    ```bash
    terraform init
    terraform apply

    # in output there should be rendered tf backend config
    ```

3. Add terraform backend

    ```
    terraform {
        backend "s3" {
            region         = "eu-west-2"
            bucket         = "miquido-devops-terraform-state"
            key            = "terraform.tfstate"
            dynamodb_table = "miquido-devops-terraform-state-lock"
            encrypt        = true
        }
    }

    module "tfstate-backend" {
        ...
    }
    ```
4. Run commands again

    ```bash
    terraform init
    terraform apply
    ```

5. When asked to copy local tfstate to s3 bucket, answer yes.
<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint Terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.20 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.20 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 1.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/tfstate-backend/aws | 1.1.1 |

## Resources

| Name | Type |
|------|------|
| [local_file.terraform_backend_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Account/Project Name | `string` | n/a | yes |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | DynamoDB read capacity units | `number` | `1` | no |
| <a name="input_role_account_id"></a> [role\_account\_id](#input\_role\_account\_id) | The AWS Account ID of IAM Role to be assumed. If none provided current caller account id will be used. | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The IAM Role name to be assumed | `string` | `"AdministratorAccess"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name. If not provided, the name will be generated by the label module in the format namespace-stage-name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on repository | `map(string)` | `{}` | no |
| <a name="input_terraform_backend_config_file_name"></a> [terraform\_backend\_config\_file\_name](#input\_terraform\_backend\_config\_file\_name) | Name of terraform backend config file | `string` | `"tfstate-backend.tf"` | no |
| <a name="input_terraform_backend_config_file_path"></a> [terraform\_backend\_config\_file\_path](#input\_terraform\_backend\_config\_file\_path) | The path to terrafrom project directory. Won't create local file if variable value is empty. Recommended: `path.module` | `string` | `""` | no |
| <a name="input_terraform_minimum_version"></a> [terraform\_minimum\_version](#input\_terraform\_minimum\_version) | Minimum version for terraform | `string` | `"0.13.5"` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | DynamoDB write capacity units | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | The ARN of created DynamoDB Table |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | The ID of created DynamoDB Table |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | The name of created DynamoDB Table |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 bucket ARN |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | S3 bucket domain name |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 bucket ID |
| <a name="output_tf_backend_config"></a> [tf\_backend\_config](#output\_tf\_backend\_config) | Rendered Terraform backend config file |
<!-- markdownlint-restore -->


## Developing

1. Make changes in terraform files

2. Regenerate documentation

    ```bash
    bash <(git archive --remote=git@gitlab.com:miquido/terraform/terraform-readme-update.git master update.sh | tar -xO)
    ```

3. Run lint

    ```
    make lint
    ```

## Copyright

Copyright © 2017-2023 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [gitlab]: https://gitlab.com/miquido
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido


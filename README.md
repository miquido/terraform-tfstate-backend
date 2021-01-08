<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# miquido-tfstate-backend
Terraform module to provision S3 Bucket for Terraform State Backend and DynamoDB Table for state locking.

### Open source modules used:
* https://github.com/cloudposse/terraform-aws-tfstate-backend
---
**Terraform Module**
## Usage

1. Use module to create bucket

    ```
    terraform {}

    module "tfstate-backend" {
        source      = "git::ssh://git@bitbucket.org/miquido/terraform-tfstate-backend.git?ref=1.0.2"
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
| terraform | >= 0.13 |
| aws | >= 2.29.0 |
| local | >= 1.3 |
| template | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.29.0 |
| local | >= 1.3 |
| template | >= 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_mode | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| environment | Environment name | `string` | `""` | no |
| name | Account/Project Name | `string` | n/a | yes |
| read\_capacity | DynamoDB read capacity units | `number` | `1` | no |
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

Copyright © 2017-2021 [Miquido](https://miquido.com)



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


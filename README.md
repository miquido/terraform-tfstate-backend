<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# miquido-tfstate-backend
Terraform module to provision S3 Bucket for Terraform State Backend and DynamoDB Table for state locking.

### Open source modules used:
* https://github.com/cloudposse/terraform-aws-tfstate-backend
---


Terraform Module

## Usage

1. Use module to create bucket

    ```
    terraform {}

    module "tfstate-backend" {
        source      = "git::ssh://git@bitbucket.com:miquido/terraform-tfstate-backend.git?ref=1.0.0"
        name        = "miquido"
        environment = "devops"
        region      = "eu-west-2"
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
## Makefile Targets
```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
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



## Developing

1. Make changes in terraform files

2. Regerate documentation

    ```bash
    bash <(curl -s https://terraform.s3.k.miquido.net/update.sh)
    ```

3. Run lint

    ```
    make lint
    ```

## Copyright

Copyright © 2017-2019 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [github]: https://github.com/miquido

# Terraform Practice

Terraform practice with linux.

## Setup:

- [Install AWS CLI](https://docs.aws.amazon.com/cli/v1/userguide/install-linux.html)
- [Install Terraform](https://developer.hashicorp.com/terraform/install#linux)



## Commands:

- ``terraform init`` => Initializes the working directory by downloading the required provider plugins and setting up the backend.

- ``terraform fmt`` => Formats Terraform configuration files to a standard format.

- ``terraform validate`` => Checks whether the configuration files are syntactically valid.

- ``terraform plan`` => Creates an execution plan, showing the changes Terraform will make to the infrastructure.

- ``terraform apply`` => Creates a resource.

- ``terraform show`` => Shows resources created. Displays the current Terraform state (from ``terraform.tfstate``). 

- ``terraform destroy`` => Destroys the infra created

## Folder Structure:

```bash
modules/
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── ec2/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── rds/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
```


## Syntax:

```sh
# provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the provider
provider "aws" {
  region = "ap-southeast-1"
}
```

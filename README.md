# Terraform Practice

Terraform practice with linux.

## Setup:

- [Install AWS CLI](https://docs.aws.amazon.com/cli/v1/userguide/install-linux.html)
- [Install Terraform](https://developer.hashicorp.com/terraform/install#linux)

Configure AWS credentials with: ``aws connnfigure``



## Commands:

- ``terraform init`` => Initializes the working directory by downloading the required provider plugins and setting up the backend.

- ``terraform fmt`` => Formats Terraform configuration files to a standard format.

- ``terraform validate`` => Checks whether the configuration files are syntactically valid.

- ``terraform plan`` => Creates an execution plan, showing the changes Terraform will make to the infrastructure.

- ``terraform apply`` => Creates a resource.

- ``terraform show`` => Shows resources created. Displays the current Terraform state (from ``terraform.tfstate``). 

- ``terraform destroy`` => Destroys the infra created

## Syntatic Sugar:

**providers definition**

```tf
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

**resource definition**

```tf
resource "<PROVIDER>_<RESOURCE_TYPE>" "<RESOURCE_NAME>" {
  <ATTRIBUTE> = <VALUE>
  <BLOCK> {
    <SUB_ATTRIBUTE> = <VALUE>
  }

  # Tags or other nested configurations
  tags = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

# example for vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name      = "main-vpc"
    CreatedBy = "terraform"
  }
}
```

- [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

- [ Cheatsheet ](https://zerotomastery.io/cheatsheets/terraform-cheat-sheet/)

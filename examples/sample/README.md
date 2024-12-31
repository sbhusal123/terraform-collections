# Sample Terraform Script To Create A VPC:

Note that this requires, aws cli and terraform to be installed.

> Run ``aws configure`` to setup your credentials, before that get your ``ACCESS_KEY`` and ``ACCESS_SECRET`` from AWS IAM for user.

## 1. Define a main.tf file as follows:

```tf
terraform {
  required_providers {

    # provider = aws
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# provider settings
provider "aws" {
  region = "ap-southeast-1"
}
```

Initialized with: ``terraform init`` this would download all the dependencies.

```sh
> terraform init

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 4.0"...
- Installing hashicorp/aws v4.67.0...
- Installed hashicorp/aws v4.67.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If 
```

## 2. Define a vpc as follows:

> vpc.tf

```tf
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    CreatedBy = "surya"
  }
}
```

Let's check what this would create.

```sh
> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.main will be created
  + resource "aws_vpc" "main" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "CreatedBy" = "surya"
          + "Name"      = "main"
        }
      + tags_all                             = {
          + "CreatedBy" = "surya"
          + "Name"      = "main"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


## 3. Create a resource:

```sh
> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.my-vpc1 will be created
  + resource "aws_vpc" "my-vpc1" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "CreatedBy" = "surya"
          + "Name"      = "main"
        }
      + tags_all                             = {
          + "CreatedBy" = "surya"
          + "Name"      = "main"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.my-vpc1: Creating...
aws_vpc.my-vpc1: Creation complete after 2s [id=vpc-0c7cb9f6189cb2204]
```

## 4. Check the resource state.

- Note that, these are stored in ``terraform.tfstate``

```sh
> terraform show

# aws_vpc.my-vpc1:
resource "aws_vpc" "my-vpc1" {
    arn                                  = "arn:aws:ec2:ap-southeast-1:879381278318:vpc/vpc-0c7cb9f6189cb2204"
    assign_generated_ipv6_cidr_block     = false
    cidr_block                           = "10.0.0.0/16"
    default_network_acl_id               = "acl-0f350cf5ecfb0b724"
    default_route_table_id               = "rtb-062e6f9920b9a0d83"
    default_security_group_id            = "sg-0be4b70a21bd70379"
    dhcp_options_id                      = "dopt-0d7202cad1411e569"
    enable_classiclink                   = false
    enable_classiclink_dns_support       = false
    enable_dns_hostnames                 = false
    enable_dns_support                   = true
    enable_network_address_usage_metrics = false
    id                                   = "vpc-0c7cb9f6189cb2204"
    instance_tenancy                     = "default"
    ipv6_association_id                  = null
    ipv6_cidr_block                      = null
    ipv6_cidr_block_network_border_group = null
    ipv6_ipam_pool_id                    = null
    ipv6_netmask_length                  = 0
    main_route_table_id                  = "rtb-062e6f9920b9a0d83"
    owner_id                             = "879381278318"
    tags                                 = {
        "CreatedBy" = "surya"
        "Name"      = "main"
    }
    tags_all                             = {
        "CreatedBy" = "surya"
        "Name"      = "main"
    }
}
```

Note, attributes here can be reffered as: ``<PROVIDER>_<RESOURCE_TYPE>.<RESOURCE_NAME>.<key>``

## 5. Now let's create a two subnets from those vpc.

> subnets.tf

```tf
# Subnet in ap-southeast-1a
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my-vpc1.id # this is reffered from 4th step
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "subnet1"
  }
}

# Subnet in ap-southeast-1b
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my-vpc1.id # this is reffered from 4th step
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "subnet2"
  }
}
```

**plan:**

```sh
> terraform plan

aws_vpc.my-vpc1: Refreshing state... [id=vpc-0c7cb9f6189cb2204]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_subnet.subnet1 will be created
  + resource "aws_subnet" "subnet1" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "subnet1"
        }
      + tags_all                                       = {
          + "Name" = "subnet1"
        }
      + vpc_id                                         = "vpc-0c7cb9f6189cb2204"
    }

  # aws_subnet.subnet2 will be created
  + resource "aws_subnet" "subnet2" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "subnet2"
        }
      + tags_all                                       = {
          + "Name" = "subnet2"
        }
      + vpc_id                                         = "vpc-0c7cb9f6189cb2204"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**create:**

```sh

aws_vpc.my-vpc1: Refreshing state... [id=vpc-0c7cb9f6189cb2204]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_subnet.subnet1 will be created
  + resource "aws_subnet" "subnet1" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "subnet1"
        }
      + tags_all                                       = {
          + "Name" = "subnet1"
        }
      + vpc_id                                         = "vpc-0c7cb9f6189cb2204"
    }

  # aws_subnet.subnet2 will be created
  + resource "aws_subnet" "subnet2" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "subnet2"
        }
      + tags_all                                       = {
          + "Name" = "subnet2"
        }
      + vpc_id                                         = "vpc-0c7cb9f6189cb2204"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_subnet.subnet2: Creating...
aws_subnet.subnet1: Creating...
aws_subnet.subnet1: Creation complete after 1s [id=subnet-0ad4747c297edce15]
aws_subnet.subnet2: Creation complete after 1s [id=subnet-0b007c889e8a463cd]
```

**let's update the cidr for subnet2:**

> subnets.tf

```tf
# Subnet in ap-southeast-1a
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my-vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "subnet1"
  }
}

# Subnet in ap-southeast-1b
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my-vpc1.id
  cidr_block        = "10.0.3.0/24" # changed here, 
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "subnet2"
  }
}
```

```sh
> terraform plan

Terraform will perform the following actions:
  # aws_subnet.subnet2 must be replaced
-/+ resource "aws_subnet" "subnet2" {
      ~ arn                                            = "arn:aws:ec2:ap-southeast-1:879381278318:subnet/subnet-0b007c889e8a463cd" -> (known after apply)
      ~ availability_zone_id                           = "apse1-az1" -> (known after apply)
      ~ cidr_block                                     = "10.0.2.0/24" -> "10.0.3.0/24" # forces replacement
      - enable_lni_at_device_index                     = 0 -> null
      ~ id                                             = "subnet-0b007c889e8a463cd" -> (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      - map_customer_owned_ip_on_launch                = false -> null
      ~ owner_id                                       = "879381278318" -> (known after apply)
      ~ private_dns_hostname_type_on_launch            = "ip-name" -> (known after apply)
        tags                                           = {
            "Name" = "subnet2"
        }
        # (12 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

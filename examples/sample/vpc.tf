# creates a vpc with vpc name: my-vpc1
resource "aws_vpc" "my-vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name      = "main"
    CreatedBy = "surya"
  }
}

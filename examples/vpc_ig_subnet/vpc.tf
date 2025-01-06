# creates a vpc with vpc name: my-vpc1
resource "aws_vpc" "surya-vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name      = "surya-vpc1"
    CreatedBy = "surya"
  }
}

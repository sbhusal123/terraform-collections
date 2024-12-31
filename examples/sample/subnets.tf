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
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "subnet2"
  }
}

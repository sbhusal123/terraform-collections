# Subnet in ap-southeast-1a
resource "aws_subnet" "surya-subnet1" {
  vpc_id            = aws_vpc.surya-vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "surya-subnet1"
    CreatedBy = "surya"
  }
}

# Subnet in ap-southeast-1b
resource "aws_subnet" "surya-subnet2" {
  vpc_id            = aws_vpc.surya-vpc1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "surya-subnet2"
    CreatedBy = "surya"
  }
}

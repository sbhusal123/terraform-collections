resource "aws_eip" "nat_ip" {
  vpc = true

  tags = {
    Name = "Nat IP"
  }
}

# create a private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "route_subnet_assoc" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private.id
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_ip.id

  connectivity_type = "public"

  depends_on = [ 
    aws_internet_gateway.gw
  ]

  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_route" "private_route_to_nat" {
    route_table_id = aws_route_table.private_rt.id
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

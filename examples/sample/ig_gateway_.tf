# create ig gateway
resource "aws_internet_gateway" "surya-aws-ig-01" {
    tags = {
        Name = "surya-aws-ig-01"
        CreatedBy = "Surya"
    }
}

# create ig gateway
resource "aws_internet_gateway_attachment" "surya-aws-ig-01-attachement" {
    internet_gateway_id = aws_internet_gateway.surya-aws-ig-01.id
    vpc_id = aws_vpc.surya-vpc1.id
}
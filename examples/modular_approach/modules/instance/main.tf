resource "aws_instance" "public" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = var.security_groups

  tags = {
    Name = "Public EC2"
  }
}

resource "aws_instance" "private" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = var.security_groups

  tags = {
    Name = "Private EC2"
  }
}

output "public_instance_ip" {
  value = aws_instance.public.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private.private_ip
}

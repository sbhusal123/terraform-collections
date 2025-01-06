resource "aws_instance" "public" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = var.security_groups

  key_name = var.key_pair

  tags = {
    Name = "Public EC2"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum install httpd -y
    mkdir -p /var/www/html
    echo "<h1>Welcome to public ec2 instance created by surya</h1>" > /var/www/html/index.html
    systemctl enable httpd
    systemctl start httpd
  EOF
}

resource "aws_instance" "private" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = var.security_groups

  user_data = <<-EOF
    #!/bin/bash
    yum install httpd -y
    mkdir -p /var/www/html
    echo "<h1>Welcome to private ec2 instance created by surya</h1>" > /var/www/html/index.html
    systemctl enable httpd
    systemctl start httpd
  EOF

  key_name = var.key_pair

  tags = {
    Name = "Private EC2"
  }
}

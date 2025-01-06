# amazone ec2 instnce ami id
variable "ami_id" {
  type    = string
  default = "ami-06dc977f58c8d7857"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "aviability_zone" {
  type    = string
  default = "ap-southeast-1a"
}

# instances type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# note that this must exist
variable "ssh_key_pair" {
  type    = string
  default = "surya-ec2-keypair"
}

# RSA key of size 4096 bits
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# take the private key and save it in a local file
# this key will be used to connect to the ec2
resource "local_file" "private_key_pem" {
  content         = tls_private_key.ec2_key.private_key_pem
  filename        = "${path.module}/ec2_key.pem"
  file_permission = "0400"
}

# create a public key in aws to use it when creating the ec2
resource "aws_key_pair" "ec2_public_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# creating security group in aws for the ec2
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-security-group"
  description = "Security group for EC2 Nginx"
  vpc_id      = "vpc-0505990984e2645a0"

  tags = {
    Name = "nginx-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.nginx_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.nginx_sg.id
  cidr_ipv4         = "0.0.0.0/0" //replace it with your ip address
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.nginx_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# creating the ec2
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "nginx_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-0cc37924a3bbbb18c"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  key_name                    = aws_key_pair.ec2_public_key.key_name
  user_data                   = file("${path.module}/init.sh")

  tags = {
    Name = "nginx-server"
  }
}
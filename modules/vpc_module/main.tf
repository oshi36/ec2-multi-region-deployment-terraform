terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}



resource "aws_vpc" "myvpc"{

	cidr_block = "10.0.0.0/16"
        enable_dns_hostnames = "true"
        enable_dns_support = "true"
}

resource "aws_internet_gateway" "myitgw" {

       vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "public" {
	cidr_block = "10.0.1.0/24"
        vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "private" {
	cidr_block = "10.0.2.0/24"
        vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myitgw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.myitgw.id
  }
}


resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "web_instance1" {
  ami           = var.ami_useast1
  instance_type = "t2.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

 tags = {
    "Name" : "web-ec2-instance1"
  }
}

resource "aws_instance" "web_instance2" {
  ami           = var.ami_useast2
  instance_type = "t2.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

 tags = {
    "Name" : "web-ec2-instance2"
  }
}

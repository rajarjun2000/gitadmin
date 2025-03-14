terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"  

  tags = {
    Name = "pub-sub"
  }
}

resource "aws_subnet" "pvtsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"  

  tags = {
    Name = "pvt-sub"
  }
}


resource "aws_internet_gateway" "vpcig" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "vpc-ig"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcig.id
  }

  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table_association" "pubrtass" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_eip" "myeip" {
    domain   = "vpc"
}   

resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pubsub.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "pvtrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tnat.id
  }

  tags = {
    Name = "pvt-rt"
  }
}

resource "aws_route_table_association" "pvrtass" {
  subnet_id      = aws_subnet.pvtsub.id
  route_table_id = aws_route_table.pvtrt.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_blocks       =["0.0.0.0/0"]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_all.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "jumpbox " {
  ami                          = "ami-05c179eced2eb9b5b"
  subnet_id                    = aws_subnet.pubsub.id
  instance_type                = "t2.micro"
  vpc_security_group_id's      = [aws_security_group.allow_all.id]
  associate_public_ip_address  = true
  key_name                     = "mumbai"
}

resource "aws_instance" "instance 2" {
  ami                          = "ami-05c179eced2eb9b5b"
  subnet_id                    = aws_subnet.pvtsub.id
  instance_type                = "t2.micro"
  vpc_security_group_id's      = [aws_security_group.allow_all.id]
  key_name                     = "mumbai"
}


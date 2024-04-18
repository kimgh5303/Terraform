provider "aws" {
  region  = var.region
}

resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc.cidr
  enable_dns_support   = var.vpc.eds
  enable_dns_hostnames = var.vpc.edh

  tags = {
    Name = var.vpc.vpc_name
  }
}

resource "aws_subnet" "mysubnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.my_subnet_1.cidr

  availability_zone = var.my_subnet_1.az

  tags = {
    Name = var.my_subnet_1.subnet_name
  }
}

resource "aws_subnet" "mysubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.my_subnet_2.cidr

  availability_zone = var.my_subnet_2.az

  tags = {
    Name = var.my_subnet_2.subnet_name
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = var.rt
  }
}

resource "aws_route_table_association" "myrtassociation1" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_route_table_association" "myrtassociation2" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_route" "mydefaultroute" {
  route_table_id         = aws_route_table.myrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
}
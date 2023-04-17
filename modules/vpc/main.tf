#Creating vpc, CIDR with tags
resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

#creating Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                        = aws_vpc.myvpc.id
  cidr_block                    = var.public_sub_1_cidr
  map_public_ip_on_launch       = "true"
  availability_zone             = var.pub_availability_zones
}

#creating Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_sub_1_cidr
  availability_zone = var.pri_availability_zones
}

#creating Internet gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
}

#creating Eip
resource "aws_eip" "myeip" {
  vpc      = true
}

#creating NAT for Private subnet
resource "aws_nat_gateway" "MyNAT" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.public_subnet.id
}

#creating Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

#creating Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.MyNAT.id
  }
}

#creating Public route table association
resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#creating private route table association
resource "aws_route_table_association" "private_1_rt_a" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

#creating Security groups
resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true 
  tags = {
    Name = "end-to-end-vpc"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az1
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Subnet a"
  }
}

resource "aws_route_table" "rt-subneta" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = local.tags_3
}

resource "aws_route_table_association" "rt-associaton" {
    subnet_id = aws_subnet.subnet_a.id
    route_table_id = aws_route_table.rt-subneta.id
}


resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az2
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Subnet b"
  }
}

resource "aws_route_table" "rt-subnetb" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = local.tags_3
}

resource "aws_route_table_association" "rt-associaton-2" {
    subnet_id = aws_subnet.subnet_b.id
    route_table_id = aws_route_table.rt-subneta.id
}


resource "aws_subnet" "subnet_c" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az1
  #map_public_ip_on_launch = "true"
  tags = {
    Name = "Subnet c"
  }
}

resource "aws_route_table" "rt-subnetc" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
 }

  tags = local.tags_3
}

resource "aws_route_table_association" "rt-associaton-3-pvt" {
    subnet_id = aws_subnet.subnet_c.id
    route_table_id = aws_route_table.rt-subnetc.id
}



resource "aws_subnet" "subnet_d" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.az2
  #map_public_ip_on_launch = "true"
  tags = {
    Name = "Subnet d"
  }
}

resource "aws_route_table" "rt-subnetd" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
 }

  tags = local.tags_3
}

resource "aws_route_table_association" "rt-associaton-4-pvt" {
    subnet_id = aws_subnet.subnet_d.id
    route_table_id = aws_route_table.rt-subnetd.id
}

resource "aws_security_group" "vpc_sg" {
  name_prefix = "vpc-"

  vpc_id = aws_vpc.my_vpc.id

  # Add any additional ingress/egress rules as needed
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
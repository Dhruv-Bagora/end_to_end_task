resource "aws_instance" "pub1" {
    ami = "ami-0ff591da048329e00"
    key_name = "dhruv_california"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet_a.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    tags = {
      Name = "public-1"
    }
}


resource "aws_instance" "pub2" {
    ami = "ami-0ff591da048329e00"
    key_name = "dhruv_california"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet_a.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    tags = {
      Name = "public-2-bation(A)"
    }
}

resource "aws_instance" "pub3" {
    ami = "ami-0ff591da048329e00"
    key_name = "dhruv_california"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet_b.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    tags = {
      Name = "public-3(B)"
    }
}

resource "aws_instance" "pvt1" {
    ami = "ami-0ff591da048329e00"
    key_name = "dhruv_california"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.subnet_c.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    root_block_device {
      volume_size = 30
      volume_type = "gp3"
    }
    tags = {
      Name = "private-1(C)"
    }
}

resource "aws_instance" "pvt2" {
    ami = "ami-0ff591da048329e00"
    key_name = "dhruv_california"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.subnet_d.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    root_block_device {
      volume_size = 30
      volume_type = "gp3"
    }
    tags = {
      Name = "private-2(D)"
    }
}
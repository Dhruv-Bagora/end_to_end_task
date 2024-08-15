resource "aws_instance" "rds_test_2" {
    ami = "ami-04a81a99f5ec58529"
    key_name = "anushka_acc"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.subnet_a.id
    vpc_security_group_ids = [ aws_security_group.vpc_sg.id ]
    tags = {
      Name = "end_to_end"
    }
}
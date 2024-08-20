resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.subnet_a.id
  tags = {
    Name = "test-nat-gateway"
  }
}
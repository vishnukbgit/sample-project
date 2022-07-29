resource "aws_eip" "nateip" {
  depends_on = [
    aws_internet_gateway.gwvpc
  ]
}


resource "aws_nat_gateway" "publicnat" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [
    aws_eip.nateip
  ]
}
############################################
# NAT Route
###########################################
resource "aws_route_table" "natroute" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.subnet_cidr2
    gateway_id = aws_nat_gateway.publicnat.id
  }



   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.publicnat.id
  }

  depends_on = [
    aws_internet_gateway.gwvpc
  ]

  tags = {
    Name = "NAT"
  }
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.natroute.id
  depends_on = [
    aws_route_table.route
  ]
}
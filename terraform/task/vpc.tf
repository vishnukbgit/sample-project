#############################
#vpc creation#
##############################

resource "aws_vpc" "vpc" {

  tags = {
    Name = "main vpc"
  }
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

}


#############################
#gateway#
##############################

resource "aws_internet_gateway" "gwvpc" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]
}

#=====================================
#route table
#======================================
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwvpc.id
  }


  depends_on = [
    aws_internet_gateway.gwvpc
  ]

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route.id
  depends_on = [
    aws_route_table.route
  ]
}
# resource "aws_route_table_association" "b" {
#   gateway_id     = aws_internet_gateway.gwvpc.id
#   route_table_id = aws_route_table.route.id
#   depends_on = [
#     aws_route_table.route
#   ]
# }



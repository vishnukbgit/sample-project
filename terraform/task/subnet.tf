
####################################
#subnet public
###################################
resource "aws_subnet" "public_subnet" {

  tags = {
    Subnet_type: "public_subnet"
    Name = "public subnet"
  }
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.zone
  map_public_ip_on_launch = true
  depends_on = [
    aws_vpc.vpc
  ]

  
}

####################################
#subnet private
###################################
resource "aws_subnet" "private_subnet" {

   tags = {
    Subnet_type: "private_subnet"
    Name = "private subnet"
  }
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr2
  availability_zone = var.zone
  map_public_ip_on_launch = false
  depends_on = [
    aws_vpc.vpc
  ]

 
}

####################################
#subnet private
###################################
resource "aws_subnet" "private_subnet2" {

   tags = {
    Subnet_type: "private_subnet2"
    Name = "private subnet2"
  }
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr3
  availability_zone = var.zone2
  map_public_ip_on_launch = false
  depends_on = [
    aws_vpc.vpc
  ]

 
}


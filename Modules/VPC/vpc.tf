# ----------------------------------------------------------------------------- #
# ------------------------------- VPC Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

# ---------------------------------------------------------------------
# Creating a VPC
# ---------------------------------------------------------------------

resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_ip

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

# ---------------------------------------------------------------------
# Creating public and private subnets
# ---------------------------------------------------------------------

resource "aws_subnet" "myPublicSubnet_1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.public_subnet_IP_1
  availability_zone = var.public_subnet_AZ_1

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

resource "aws_subnet" "myPublicSubnet_2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.public_subnet_IP_2
  availability_zone = var.public_subnet_AZ_2

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

resource "aws_subnet" "myPrivateSubnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_subnet1_IP
  availability_zone = var.private_subnet1_AZ

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

resource "aws_subnet" "myPrivateSubnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_subnet2_IP
  availability_zone = var.private_subnet2_AZ

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

# ---------------------------------------------------------------------
# Creating an Internet Gateway
# ---------------------------------------------------------------------

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}


# ----------------------------------------------------------------------
# Creating a public route table and associate it with the public subnets
# ----------------------------------------------------------------------

# Creating a route table.
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}


# Associating the route table with the subnets.
resource "aws_route_table_association" "Subnet-RouteTable-Association1" {

  subnet_id      = aws_subnet.myPublicSubnet_1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "Subnet-RouteTable-Association2" {

  subnet_id      = aws_subnet.myPublicSubnet_2.id
  route_table_id = aws_route_table.public-route-table.id
}


# ------------------------------------------------------------------------
# Creating a private route table and associate it with the private subnets
# ------------------------------------------------------------------------

# Creating route table.
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}

# Associating the route table with subnets.
resource "aws_route_table_association" "Subnet-RouteTable-Association4" {

  subnet_id      = aws_subnet.myPrivateSubnet1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "Subnet-RouteTable-Association5" {

  subnet_id      = aws_subnet.myPrivateSubnet2.id
  route_table_id = aws_route_table.private-route-table.id
}
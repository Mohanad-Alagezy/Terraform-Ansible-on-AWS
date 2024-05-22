# ----------------------------------------------------------------------------- #
# ------------------------------- RDS Module ---------------------------------- #
# ----------------------------------------------------------------------------- #


# --------------------------------------------------------------
# Creating a subnet group for RDS instance
# --------------------------------------------------------------

resource "aws_db_subnet_group" "mySubnetGroup" {
  name       = var.EC2_Subnet_group
  subnet_ids = [var.subnet-1-id, var.subnet-2-id]

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}


# --------------------------------------------------------------
# Creating RDS instance 
# --------------------------------------------------------------

resource "aws_db_instance" "myDB" {

  identifier             = "MohanadRDS"
  db_name                = "MohanadDB"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  license_model          = "general-public-license"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  max_allocated_storage  = 0
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.mySubnetGroup.name
  vpc_security_group_ids = [var.SG_id]
  port                   = 3306
  username               = "admin"
  password               = "MyDummyPassword#"
  skip_final_snapshot    = true

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }
}



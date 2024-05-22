# --------------------------------------------------------------
# Creating a VPC
# --------------------------------------------------------------

module "main_VPC" {
  source             = "./Modules/VPC"
  vpc_ip             = var.main_vpc_ip
  public_subnet_IP_1 = var.public_subnet_IP_1
  public_subnet_IP_2 = var.public_subnet_IP_2
  public_subnet_AZ_1 = var.public_subnet_AZ_1
  public_subnet_AZ_2 = var.public_subnet_AZ_2
  private_subnet1_IP = var.private_subnet1_IP
  private_subnet2_IP = var.private_subnet2_IP
  private_subnet1_AZ = var.private_subnet1_AZ
  private_subnet2_AZ = var.private_subnet2_AZ

}


# --------------------------------------------------------------
# Creating Security Group for both EC2 instances
# --------------------------------------------------------------

module "EC2_SG" {
  source      = "./Modules/Security Group"
  name        = "allow-http-ssh"
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic."
  vpc_id      = module.main_VPC.vpc_id


  ingress_rules = {
    http = {
      cidr_ipv4                    = "0.0.0.0/0"
      referenced_security_group_id = null
      from_port                    = 80
      ip_protocol                  = "tcp"
      to_port                      = 80
    }
    ssh = {
      cidr_ipv4                    = "0.0.0.0/0"
      referenced_security_group_id = null
      from_port                    = 22
      ip_protocol                  = "tcp"
      to_port                      = 22
    }
  }
}


# --------------------------------------------------------------
# Creating first EC2 instance
# --------------------------------------------------------------

module "first_instance" {
  source             = "./Modules/EC2"
  instance_ami       = var.instance_ami
  instance_type      = var.instance_type
  instance_subnet_id = module.main_VPC.public_subnet_id_1
  SG_id              = module.EC2_SG.SecurityGroup_ID
}


# --------------------------------------------------------------
# Creating second EC2 instance
# --------------------------------------------------------------

module "second_instance" {
  source             = "./Modules/EC2"
  instance_ami       = var.instance_ami
  instance_type      = var.instance_type
  instance_subnet_id = module.main_VPC.public_subnet_id_2
  SG_id              = module.EC2_SG.SecurityGroup_ID
}


# --------------------------------------------------------------
# Creating Security Group for RDS instance
# --------------------------------------------------------------

module "RDS_SG" {
  source      = "./Modules/Security Group"
  name        = "allow-db-connection"
  description = "Allow inbound traffic on port 3306 and all outbound traffic."
  vpc_id      = module.main_VPC.vpc_id


  ingress_rules = {
    mysql = {
      cidr_ipv4                    = null
      referenced_security_group_id = module.EC2_SG.SecurityGroup_ID
      from_port                    = 3306
      ip_protocol                  = "tcp"
      to_port                      = 3306
    }
  }
}


# --------------------------------------------------------------
# Creating RDS instance
# --------------------------------------------------------------

module "main_RDS" {
  source           = "./Modules/RDS"
  subnet-1-id      = module.main_VPC.private_subnet1_id
  subnet-2-id      = module.main_VPC.private_subnet2_id
  SG_id            = module.RDS_SG.SecurityGroup_ID
  EC2_Subnet_group = var.sub_group_name
}

# --------------------------------------------------------------
# Creating Application Load Balancer
# --------------------------------------------------------------

module "main_ALB" {
  source               = "./Modules/ALB"
  target_instance_1_id = module.first_instance.EC2_id
  target_instance_2_id = module.second_instance.EC2_id
  vpc_id               = module.main_VPC.vpc_id
  subnet-1-id          = module.main_VPC.public_subnet_id_1
  subnet-2-id          = module.main_VPC.public_subnet_id_2
}
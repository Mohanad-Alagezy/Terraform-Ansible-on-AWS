# ---------------------------------------------------------------------
# Needed values for the project's various components
# ---------------------------------------------------------------------

main_vpc_ip        = "10.0.0.0/16"
public_subnet_IP_1 = "10.0.10.0/24"
public_subnet_IP_2 = "10.0.20.0/24"
public_subnet_AZ_1 = "us-east-1a"
public_subnet_AZ_2 = "us-east-1b"
private_subnet1_IP = "10.0.40.0/24"
private_subnet2_IP = "10.0.50.0/24"
private_subnet1_AZ = "us-east-1a"
private_subnet2_AZ = "us-east-1b"

instance_type = "t2.micro"
instance_ami  = "ami-07caf09b362be10b8"
region        = "us-east-1"

sub_group_name = "mohanad-db-subnet-group"

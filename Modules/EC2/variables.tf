# -------------------------------------------------------------- #
# -------------------- EC2 Module Variables -------------------- #
# -------------------------------------------------------------- #


# --------------------------------------------------------------
# Variables for the instance itself
# --------------------------------------------------------------

variable "instance_type" {
  type        = string
  description = "The size of the EC2 instance"
}

variable "instance_ami" {
  type        = string
  description = "The AMI of the EC2 instance"
}

variable "instance_subnet_id" {
  type        = string
  description = "The ID of the subnet in which the EC2 instance will be deployed"
}


# --------------------------------------------------------------
# Variables for the security group
# --------------------------------------------------------------

variable "SG_id" {
  type        = string
  description = "The ID of the security group that will be attached to the EC2 instance"
}
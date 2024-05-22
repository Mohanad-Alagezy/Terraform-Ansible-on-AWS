# -------------------------------------------------------------- #
# -------------------- RDS Module Variables -------------------- #
# -------------------------------------------------------------- #


# --------------------------------------------------------------
# Variables for the subnet group
# --------------------------------------------------------------

variable "EC2_Subnet_group" {
  type        = string
  description = "The name of subnet group"
}

variable "subnet-1-id" {
  type        = string
  description = "The ID of first subnet in subnet group"
}

variable "subnet-2-id" {
  type        = string
  description = "The ID of second subnet in subnet group"
}


# --------------------------------------------------------------
# Variables for RDS
# --------------------------------------------------------------

variable "SG_id" {
  type        = string
  description = "The ID of the RDS security group"
}
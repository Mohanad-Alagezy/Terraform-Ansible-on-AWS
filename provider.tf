# --------------------------------------------------------------------------
# Fetching AWS provider and setting the project backend to be remote on AWS
# --------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-project-statefile-bucket"
    key            = "states/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-project-statefile-table"
  }
}


# ---------------------------------------------------------------------
# Setting the configurations of AWS provider
# ---------------------------------------------------------------------

provider "aws" {
  region  = var.region
  profile = "default"
}
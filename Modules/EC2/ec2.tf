# ----------------------------------------------------------------------------- #
# ------------------------------- EC2 Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------
# Creating EC2 Instance
# -------------------------------------------------------------------------------

resource "aws_instance" "myServer" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.SG_id]

  tags = {
    Deployment  = "Terraform"
    Environment = "Testing"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.myServer.public_ip}, install_services.yml"
  }
}
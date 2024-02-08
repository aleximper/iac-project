resource "aws_network_interface" "private" {
  subnet_id       = var.private_subnet
  security_groups = var.security-groups
  private_ip = var.private_ip
}

#####################
# EC2 instance
#####################
resource "aws_instance" "instance" {
  instance_type           = var.class_instance
  key_name                = var.key_name
  ami                     = var.ami
  disable_api_termination = true

  network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index         = 0
  }

  root_block_device {
    delete_on_termination = true
    volume_type = "gp3"
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}
locals {
  m_conf={
    m1={
      ip="172.16.128.10"
      subnet=local.private_subnets[0]
    }
    m2={
      ip="172.16.130.10"
      subnet=local.private_subnets[1]
    }
    m3={
      ip="172.16.128.11"
      subnet=local.private_subnets[0]
    }
  }  
}

module "ec2" {
  for_each = local.m_conf
  source = "../../tf-modules/ec2"
  class_instance = "t3.micro"
  security-groups = aws_security_group.fw_internal.id
  private_ip = each.value.ip
  ami = "ami-059f4aad319ff1bc3"
  private_subnet = each.value.subnet
  key_name = local.key_name
}
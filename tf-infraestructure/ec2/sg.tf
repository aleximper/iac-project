locals {
  fw_internal_sg_ingress_rules = {
    vpc = {
      description = "From VPC to FW"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = local.vpc_cidr
    }
    vpn = {
      description = "From VPN to FW"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = local.vpn_cidr
    }
  }
  private_subnets = {
    prod = local.private_subnets_id
    dev  = local.private_subnets_id
  }
}

######################
# Security groups
######################
resource "aws_security_group" "fw_internal" {
  name        = "${local.app_name}-${local.environment}-sg-internal"
  description = "Allow traffic from VPC"
  vpc_id      = local.vpc_id
  tags = {
    Name = "${local.app_name}-${local.environment}-sg-internal"
  }
}

resource "aws_security_group_rule" "fw_ingress_internal" {
  for_each          = local.fw_internal_sg_ingress_rules
  type              = "ingress"
  description       = try(each.value.description, null)
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.fw_internal.id
  depends_on = [
    aws_security_group.fw_internal
  ]
}

resource "aws_security_group_rule" "fw_egress_internal" {
  type              = "egress"
  protocol          = -1
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.fw_internal.id
  depends_on = [
    aws_security_group.fw_internal
  ]
}
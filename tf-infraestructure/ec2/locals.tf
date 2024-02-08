locals {
  #-----------------------------------------
  # Global Variables
  #-----------------------------------------
  environment         = terraform.workspace #Or change this value by the account name in lowercase
  organization_prefix = "app"
  region              = "us-east-1"
  this_account_id     = "xxxxxxxxxxxx"

  #-----------------------------------------
  # Resource names
  #-----------------------------------------
  default_name           = lower("${local.organization_prefix}-${local.environment}")
  private_subnets_id     = data.terraform_remote_state.main.outputs.private_subnet_ids[0]
  public_subnets_id      = data.terraform_remote_state.main.outputs.public_subnet_ids[0]
  vpn_cidr               = data.terraform_remote_state.main.outputs.vpn_subnet_cidrs
  domain_name            = data.terraform_remote_state.domain.outputs.domain_name
  dns_zone_id            = data.terraform_remote_state.domain.outputs.route53_zoneid
  vpc_id                 = data.terraform_remote_state.main.outputs.vpc_id
  vpc_cidr               = [data.terraform_remote_state.main.outputs.vpc_cidr]
  private_route_table_id = data.terraform_remote_state.main.outputs.private_route_table_ids
  public_route_table_id  = data.terraform_remote_state.main.outputs.public_route_table_ids
  app_name               = "ec2"
  key_name               = "ec2"
}
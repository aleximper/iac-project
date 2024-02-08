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
  default_name = lower("${local.organization_prefix}-${local.environment}")
  vpc_id = data.terraform_remote_state.main.outputs.vpc_id
}
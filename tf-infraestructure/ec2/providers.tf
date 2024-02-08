locals {
  backup_scheme = {
    prod = 1
    dev  = 1
  }
  abs_path     = split("/", abspath(path.module))
  abs_path_str = join("/", [for value in local.abs_path : value if index(local.abs_path, value) >= index(local.abs_path, "tf-infraestructure")])
  default_tags = {
    Environment    = local.environment
    Managed-by     = "terraform"
    Team           = "DevOps"
    IaC-Repository = "infrastructure"
    Service        = "Firewall"
    BackupScheme   = try(local.backup_scheme[terraform.workspace], 2) #NOTE: At the moment this only apply for the ec2 resources. This field could has these values:
    #1 daily backup (Production env).
    #2 weekly backup.
    #3 mounthly backup.
    TF-Folder = local.abs_path_str
  }
}

# ------------------------------------------------------------------------
# AWS provider settings
# ------------------------------------------------------------------------

provider "aws" {
  region = local.region

  default_tags {
    tags = local.default_tags
  }

  assume_role {
    role_arn = "arn:aws:iam::${local.this_account_id}:role/terraformrole"
  }

  allowed_account_ids = [local.this_account_id]

}
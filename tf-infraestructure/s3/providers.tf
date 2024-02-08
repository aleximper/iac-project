locals {
  default_tags = {
    BillingCategory = "${local.organization_prefix}-${title(local.environment)}"
    Environment     = "prod"
    Managed-by      = "terraform"
    Team            = "DevOps"
    IaC-Repository  = "infrastructure"
    #Country         = "ALL"
    #Business-Impact = "" Uncomment this line regarding to the business impact list defined, contact to the DevOps Team to get it.
    BackupScheme = "NA" #NOTE: At the moment this only apply for the ec2 resources.
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
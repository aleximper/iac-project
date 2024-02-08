locals {
  vpc_cidrs = {
    prod = ["172.16.0.0/16"]
  }

  azs = ["us-east-1a", "us-east-1b"]
  public_cidrs = {
    prod = [cidrsubnet(local.vpc_cidrs["prod"][0], 7, 0), cidrsubnet(local.vpc_cidrs["prod"][0], 7, 1)]
  }

  private_cidrs = {
    prod = [cidrsubnet(local.vpc_cidrs["prod"][0], 7, 63), cidrsubnet(local.vpc_cidrs["prod"][0], 7, 64)]
  }

  vpn_cidrs = {
    prod = ["172.18.0.0/24"]
  }
}

module "vpc" {
  source               = "../../tf-modules/vpc"
  environment          = local.environment
  vpc_name             = "${local.default_name}-vpc"
  vpc_cidr             = local.vpc_cidrs[prod][0]
  azs                  = local.azs
  public_subnet_cidrs  = local.public_cidrs[prod]
  private_subnet_cidrs = local.private_cidrs[prod]
}
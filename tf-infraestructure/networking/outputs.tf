output "environment" {
  description = "Name of the environment we provisioned the VPC for"
  value       = module.vpc.environment
}

output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = module.vpc.vpc_id
  sensitive   = true
}

output "vpc_cidr" {
  description = "CIDR of the overall environment config (covering all subnets)"
  value       = module.vpc.vpc_cidr
  sensitive   = true
}

output "igw_id" {
  description = "Internet Gateway ID provisioned"
  value       = module.vpc.igw_id
  sensitive   = true
}

output "azs" {
  description = "List of Availability Zones provisioned within"
  value       = local.azs
}

output "public_subnet_ids" {
  description = "List of public subnet IDs provisioned"
  value       = module.vpc.public_subnet_ids
  sensitive   = true
}

output "public_subnet_cidrs" {
  description = "List of public subnet cidr blocks provisioned"
  value       = module.vpc.public_subnet_cidrs
  sensitive   = true
}

output "private_subnet_ids" {
  description = "List of private subnet IDs provisioned"
  value       = module.vpc.private_subnet_ids
  sensitive   = true
}

output "private_subnet_cidrs" {
  description = "List of private subnet cidr blocks provisioned"
  value       = module.vpc.private_subnet_cidrs
  sensitive   = true
}

output "public_route_table_ids" {
  description = "List of the public route tables defined"
  value       = module.vpc.public_route_table_ids
  sensitive   = true
}

output "private_route_table_ids" {
  description = "List of the private route tables defined"
  value       = module.vpc.private_route_table_ids
  sensitive   = true
}

output "db_subnet_ids" {
  description = "List of database subnet IDs provisioned"
  value       = module.vpc.db_subnet_ids
  sensitive   = true
}

output "db_subnet_cidrs" {
  description = "List of database subnet cidr blocks provisioned"
  value       = module.vpc.db_subnet_cidrs
  sensitive   = true
}

output "vpn_subnet_cidrs" {
  description = "List of vpn subnet cidr blocks provisioned"
  value       = local.vpn_cidrs[terraform.workspace]
  sensitive   = true
}

output "nat_gw_ids" {
  description = "List of NAT Gateway IDs provisioned"
  value       = module.vpc.nat_gw_ids
  sensitive   = true
}
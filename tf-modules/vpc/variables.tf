variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "environment" {
  description = "Name of the environment (terraform.workspace or static environment name for vpcs not managed with a workspace)"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR range for the VPC"
  type        = string
}


variable "enable_dns_support" {
  description = "True if the DNS support is enabled in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "True if DNS hostnames is enabled in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "The type of tenancy for EC2 instances launched into the VPC"
  type        = string
  default     = "default"
}
# -------------------------------------------------------------
# Tagging
# -------------------------------------------------------------

variable "tags" {
  description = "A map of tags for the VPC resources"
  type        = map(string)
  default     = {}
}

variable "private_dns_enabled" {
  description = "VPC private DNS set"
  type        = bool
  default     = false
}

variable "azs" {
  description = "vpc zones availability"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidrs" {
  description = "cidrs for public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "cidrs for private subnets"
  type        = list(string)
  default     = []
}

variable "db_subnet_cidrs" {
  description = "cidrs for databases subnets"
  type        = list(string)
  default     = []
}
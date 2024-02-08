# --------------------------------------------------------------------
# Virtual Private Cloud (VPC) network resources
# --------------------------------------------------------------------

###
# Virtual Private Cloud (VPC)
###
resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
  tags = merge(
    {
      "Name" = var.vpc_name
    },
    var.tags,
  )
}

###
# Internet Gateway
# ----------------
# We only create this if we actually have public subnets defined and if "enable_igw" 
# is true (this is also the default).   For typical VPC provisioning, this should be 
# left in.  For transit gateway deployments, it may be desirable to not.
###
resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = "${var.environment}-igw"
    },
    var.tags,
  )
  depends_on = [aws_vpc.this]
}

###
# Public Subnets
###
resource "aws_subnet" "public_subnets" {

  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index % length(var.azs))
  tags = merge(
    {
      "Name" = "${var.environment}-public-${element(var.azs, count.index)}-subnet"
    },
    var.tags,
  )
  depends_on = [aws_vpc.this]
}

###
# Private Subnets
###

resource "aws_subnet" "private_subnets" {

  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index % length(var.azs))
  tags = merge(
    {
      "Name" = "${var.environment}-private-${element(var.azs, count.index)}-subnet"
    },
    var.tags,
  )
  depends_on = [aws_vpc.this]
}

###
# Elastic IP(s) for NAT Gateway(s) 
# --------------------------------
# See NAT Gateway(s) for the logic on enable_igw
###
resource "aws_eip" "elastic_ip" {
  count  = length(var.azs)
  domain = "vpc"
  tags = merge(
    {
      "Name" = "${var.environment}-natgw-elasticIP-${count.index + 1}"
    },
    var.tags,
  )
  depends_on = [aws_vpc.this]
}

###
# NAT Gateway(s)
# --------------
###
resource "aws_nat_gateway" "nat_gw" {
  count = length(var.azs)

  allocation_id = element(aws_eip.elastic_ip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  tags = merge(
    {
      "Name" = "${var.environment}-natgw-${count.index + 1}"
    },
    var.tags,
  )
  depends_on = [aws_subnet.public_subnets, aws_eip.elastic_ip]
}

###
# Route table for public subnets
###
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = "${var.environment}-rt-public"
    },
    var.tags,
  )
}

###
# Route table(s) for private subnets
# ----------------------------------
###
resource "aws_route_table" "private" {
  count = length(var.azs)

  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = "${var.environment}-rt-private_subnets-${count.index + 1}"
    },
    var.tags,
  )
}

###
# Associate route table with public subnets
# -----------------------------------------
# In current design, we only make 1 public RT, hence all subnets go to that public.id
###
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

###
# Associate private route table(s) with private subnets
###
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

###
# VPC Main Route Table association
# --------------------------------
###
resource "aws_main_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id         = aws_vpc.this.id
  route_table_id = element(aws_route_table.private.*.id, 0)
}

resource "aws_main_route_table_association" "public" {
  count = length(var.public_subnet_cidrs) > 0 && length(var.private_subnet_cidrs) == 0 ? 1 : 0

  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.public.id
}

###
# Route(s) to Internet through the NAT Gateway(s)
###
resource "aws_route" "nat_gw_route" {
  count = length(var.azs)

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)
}

###
# Route(s) to the internet from the Public Route Table if enable_igw is true
###
resource "aws_route" "igw_default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
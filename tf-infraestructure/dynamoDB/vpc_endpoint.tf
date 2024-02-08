module "vpc_endpoint" {
  source = "../../tf-modules/vpc_endpoint"
  vpc_id = local.vpc_id
  service_name = "com.amazonaws.us-east-1.dynamodb"
}
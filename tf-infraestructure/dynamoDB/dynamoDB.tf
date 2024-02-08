module "dynamoDB" {
  source      = "../../tf-modules/dynamoDB"
  name = "clouxter-prueba-item-3"
  hash_key = "UserId"
  billing = "PROVISIONED"
  name_attribute = "UserId"
  attribute_type = "s"
}

module "vpc_endpoint" {
  source = "../../tf-modules/vpc_endpoint"
  vpc_id = local.vpc_id
  service_name = "com.amazonaws.us-east-1.dynamodb"
}
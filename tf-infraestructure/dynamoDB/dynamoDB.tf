module "dynamoDB" {
  source      = "../../tf-modules/dynamoDB"
  name = "clouxter-prueba-item-3"
  hash_key = "UserId"
  billing = "PROVISIONED"
  name_attribute = "UserId"
  attribute_type = "s"
}
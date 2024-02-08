resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.name
  billing_mode   = var.billing
  hash_key       = var.hash_key

  attribute {
    name = var.name_attribute
    type = var.attribute_type
  }
}
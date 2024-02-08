variable "name" {
  type= string
  description = "Dynamo DB Name"
}

variable "billing" {
  type = string
  description = "billing mode for Dynamo"
}

variable "hash_key" {
  type = string
}

variable "name_attribute" {
  type = string
}

variable "attribute_type" {
  type = string
}
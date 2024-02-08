variable "private_subnet" {
  type = string
  description = "id private subnet"
}

variable "security-groups" {
  type = set(string)
  description = "ID security group"
}

variable "class_instance"{
  type = string
  description = "Instance class"
}

variable "key_name" {
  type = string
  description = "private key for ssh access"
}

variable "ami" {
  type = string
  description = "ID AMI"
}

variable "private_ip" {
  type = string
  description = "private ip ec2 instance"
}


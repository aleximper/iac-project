terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "tf-state"
    key            = "s3/infrastructure.tfstate"
    dynamodb_table = "terraform_locks"
    role_arn       = "arn:aws:iam::xxxxxxxxxxxx:role/terraformrole"
    encrypt        = "true"
  }
}

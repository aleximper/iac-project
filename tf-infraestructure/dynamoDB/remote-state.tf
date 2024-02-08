################################################
# Access to vpc project retrieving the outputs
################################################
data "terraform_remote_state" "main" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    region         = "us-east-1"
    bucket         = "tf-state"
    key            = "main/infrastructure.tfstate"
    dynamodb_table = "terraform_locks"
    assume_role = {
      role_arn = "arn:aws:iam::864106799048:role/terraformrole"
    }
  }
}
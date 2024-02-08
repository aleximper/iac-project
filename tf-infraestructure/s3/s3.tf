module "s3_keypairs" {
  source      = "../../tf-modules/s3"
  bucket_name = "s3-pruebaclouxter-item-4"
  versioning  = true
}

module "vpc_endpoint" {
  source = "../../tf-modules/vpc_endpoint"
  vpc_id = local.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
}
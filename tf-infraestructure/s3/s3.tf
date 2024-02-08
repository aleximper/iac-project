module "s3_keypairs" {
  source      = "../../tf-modules/s3"
  bucket_name = "s3-pruebaclouxter-item-4"
  versioning  = true
}
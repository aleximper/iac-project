
resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name

  dynamic "server_side_encryption_configuration" {
    for_each = var.encryption ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = var.kms_master_key_id
          sse_algorithm     = var.sse_algorithm
        }
      }
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      replication_configuration
    ]
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.versioning == true ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}



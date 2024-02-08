# ------------------------------------------------------------------------
# Amazon S3 variables
# ------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Tags to be added to all the resources."
  default     = {}
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. Must be less than or equal to 63 characters in length."
}

variable "versioning" {
  type        = bool
  default     = false
  description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket."
}

variable "encryption" {
  type        = bool
  default     = true
  description = "A single object for server-side encryption by default configuration. Valid values are true/false."
}

variable "sse_algorithm" {
  type        = string
  default     = "aws:kms"
  description = "aws:kms or AES256"
}

variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
}

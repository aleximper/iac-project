# --------------------------------------------------------------------
# Amazon S3 buckets output
# --------------------------------------------------------------------

output "id" {
  description = "The bucket name name."
  value       = aws_s3_bucket.bucket.id
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
  value       = aws_s3_bucket.bucket.arn
}
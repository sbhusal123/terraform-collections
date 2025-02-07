output "bucket_arn" {
  value = aws_s3_bucket.lambda_trigger_bucket.arn
}

output "bucket_id" {
  value = aws_s3_bucket.lambda_trigger_bucket.id
}

output "bucket_name" {
  value = var.bucket_name
}
# invoke lambda on s3 event
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_func_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}


# create a notiication when object created
resource "aws_s3_bucket_notification" "s3_to_lambda" {
  bucket = var.s3_bucket_id

  lambda_function {
    lambda_function_arn = var.lambda_func_arn
    # Trigger Lambda when a new object is uploaded
    events              = ["s3:ObjectCreated:*"]
  }
}

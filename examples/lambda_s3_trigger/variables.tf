variable "aws_region" {
  default     = "ap-southeast-1"
  description = "AWS Region"
}

variable "lambda_name" {
  description = "Name of lambda function"
  type        = string
  default     = "bucket_trigger_lambda"
}
variable "s3_bucket_id" {
    description = "Id of a S3 bucket that triggers lambda"
    type = string
}

variable "s3_bucket_arn" {
    description = "ARN of a S3 bucket that triggers lambda"
    type = string
}

variable "lambda_func_arn" {
    description = "ARN of lambda function"
    type = string
}

variable "lambda_func_name" {
    description = "Name of lambda function"
    type = string
}

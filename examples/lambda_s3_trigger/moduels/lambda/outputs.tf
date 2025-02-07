output "lambda_arn" {
    description = "ARN of a lambda."
    value = aws_lambda_function.s3_lambda.arn
}

output "lambda_id" {
    description = "ID of a lambda."
    value = aws_lambda_function.s3_lambda.id
}

resource "aws_lambda_function" "s3_lambda" {
  function_name    = var.lambda_func_name

  # name of main method in python file for lambda function: file.method
  handler          = "lambda_function.main"
  runtime          = var.python_version
  role             = var.lambda_role_arn
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
}

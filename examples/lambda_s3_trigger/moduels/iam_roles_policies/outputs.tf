output "lambda_func_role_arn" {
  description = "Role arn by which lambda function needs to get executed"
  value = aws_iam_role.lambda_exec_role.arn
}

# create assume role such that, resource attaches will have all policies as allowed in the role for lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


# policy for a role
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "Policy for Lambda to access S3 and CloudWatch"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow Lambda to write logs to CloudWatch
      {
        Effect   = "Allow"
        Action   = ["logs:*"]
        # arn pattern for cloudwatch logs
        Resource = "arn:aws:logs:*:*:*"
      },
      # Allow Lambda to access S3
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:ListBucket"]
        Resource = [
          var.lambda_trigger_bucket_arn,
          "${var.lambda_trigger_bucket_arn}/*"
        ]
      }
    ]
  })
}


# attach policy on a role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

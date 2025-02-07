# AWS Lambda Trigger On S3 Put Event

This creates a lambda function with proper roles and politices such that when S3 bucket is uploaded, then the lambda function gets triggered.

Creates:

## S3 Bucket:

```
resource "aws_s3_bucket" "lambda_trigger_bucket" {
    bucket = var.bucket_name
}
```

We will use this s3 bucket to trigger a lambda when file/object is uploaded.

Note that whenever a python file is changes, it needs to be zipped again to deploy the changes.


## IAM Roles and Policies:

Before Creating a lambda:

We need to tell lambda that it has access to CloudWatch and S3 Bucket. To do so, we first create a role, which is a Assume role.

```python
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
```

Since, this role doesnt have policies, it doesnt knows which policies to assume it has access to. Let's create it.

```python
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
```

We created a policy for allowing access to cloudwatch and S3 Get and List object. Let's attach it to the role.

```python
# attach policy on a role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
```

So, this way we created a role and policy. Next We need to attach a same role to the lambda while creating it.


## Lambda Function

```
resource "aws_lambda_function" "s3_lambda" {
  function_name    = var.lambda_func_name

  # name of main method in python file for lambda function: file.method
  handler          = "lambda_function.main"
  runtime          = var.python_version
  role             = var.lambda_role_arn
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
}
```

Here, we created a lambda function with:
- A zip python file.

- Handler "<file_name>.<method>" defines a lambda handler function

- Role is the ARN (Amazon Resource Name) of the role we created in step above.

So, far we created a bucket, lambda and the roles and policies for lambda.

Now, the next step is to glue lambda and s3 together and tell s3 to trigger lambda on object created event.

## Triggering

Now, we need S3 to have access to invoke a lambda function.

```python
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_func_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}
```

Here s3 bucket with ``source_arn`` can now do action of ``lambda:InvokeFunction`` on `function_name` which is our lambda function name.

SO, this basically defines that:
- ``AllowExecutionFromS3Bucket`` from S3 bucket of source_arn
- To perform action ``lambda:InvokeFunction`` of lambda function named ``function_name``

That was just the way we grant a permission of doing some ``action`` on some resouce from ``source_arn`` to execute ``function_name`` (lambda)

Now we need to tell it that, lambda function to trigger a bucket create event when bucket is created.

```python
# create a notiication when object created
resource "aws_s3_bucket_notification" "s3_to_lambda" {
  bucket = var.s3_bucket_id

  lambda_function {
    lambda_function_arn = var.lambda_func_arn
    # Trigger Lambda when a new object is uploaded
    events              = ["s3:ObjectCreated:*"]
  }
}
```

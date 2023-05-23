# Create an S3 bucket for storing the exported Excel file
resource "aws_s3_bucket" "excel_bucket" {
  bucket = "your-bucket-name"
  acl    = "private"
}

# Create an SNS topic for sending email notifications
resource "aws_sns_topic" "email_topic" {
  name = "your-topic-name"
}

# Create an IAM role for the Lambda function to execute
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach necessary policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Create the Lambda function
resource "aws_lambda_function" "user_export_lambda" {
  filename      = "user_export_lambda.zip"
  function_name = "user_export_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 300

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.excel_bucket.bucket
    }
  }
}

# Create a CloudWatch event rule to trigger the Lambda function every week
resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name        = "lambda-trigger"
  description = "Trigger Lambda function every week"
  schedule_expression = "rate(1 week)"
}

# Associate the CloudWatch event rule with the Lambda function
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger.name
  target_id = "lambda-target"
  arn       = aws_lambda_function.user_export_lambda.arn
}

# Grant permissions for the Lambda function to write to the S3 bucket
resource "aws_lambda_permission" "s3_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.user_export_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn
}




# Subscribe to the SNS topic for receiving email notifications
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.email_topic.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}



# Grant permissions for the SNS topic to publish to the Lambda function
resource "aws_lambda_permission" "sns_permission" {
  statement_id  = "AllowSNSToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.user_export_lambda.function_name
  principal     = "arn:aws:sns:ap-southeast-1:099597531506:email"
}

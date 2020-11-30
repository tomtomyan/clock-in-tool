resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "clock_in" {
  filename      = "lambda.zip"
  function_name = "Clock_In"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  layers        = ["arn:aws:lambda:us-east-1:764866452798:layer:chrome-aws-lambda:18"]
  memory_size   = 2048

  source_code_hash = filebase64sha256("lambda.zip")

  runtime = "nodejs12.x"
  timeout = 20
}

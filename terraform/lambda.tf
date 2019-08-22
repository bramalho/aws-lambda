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

resource "aws_lambda_function" "it_works_lambda" {
  filename      = "${path.module}/../functions/it_works.zip"
  function_name = "it_works"
  runtime       = "python3.6"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "it_works.lambda_handler"
  source_code_hash = "${filebase64sha256("${path.module}/../functions/it_works.zip")}"
}

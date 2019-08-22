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
  depends_on    = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.lambda_log_group"]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/cloudwatch_log_group"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "lambda_log_stream" {
  name           = "lambda_log_stream"
  log_group_name = "${aws_cloudwatch_log_group.lambda_log_group.name}"
}

resource "aws_iam_policy" "lambda_logging" {
  name   = "lambda_logging"
  path   = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}

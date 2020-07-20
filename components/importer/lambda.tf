resource "aws_lambda_function" "test_lambda" {
  filename      = "resources/hello-world.zip"
  function_name = var.name_prefix
  role          = aws_iam_role.lambda.arn
  handler       = "hello-world.lambda_handler"
  source_code_hash = "${filebase64sha256("resources/hello-world.zip")}"

  runtime = "python3.8"

  tags = var.tags
}

resource "aws_lambda_function" "importer" {
  filename         = "resources/hello-world.zip"
  function_name    = var.name_prefix
  role             = aws_iam_role.importer.arn
  handler          = "src/handlers/import.lambda_handler"
  source_code_hash = filebase64sha256("resources/hello-world.zip")

  tracing_config {
    mode = "Active"
  }

  runtime = "python3.8"

  tags = var.tags
}

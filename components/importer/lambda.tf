resource "aws_lambda_function" "importer" {
  # checkov:skip=CKV_AWS_50:skipping
  filename         = "resources/hello-world.zip"
  function_name    = var.name_prefix
  role             = aws_iam_role.importer.arn
  handler          = "src/import.lambda_handler"
  source_code_hash = filebase64sha256("resources/hello-world.zip")
  layers           = [aws_lambda_layer_version.dependencies.arn]

  runtime = "python3.8"

  tags = var.tags
}

resource "aws_lambda_layer_version" "dependencies" {
  filename   = "resources/hello-world.zip"
  layer_name = "${var.name_prefix}-dependencies"

  compatible_runtimes = ["python3.8"]
}

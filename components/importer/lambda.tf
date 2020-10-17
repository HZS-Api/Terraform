resource "aws_lambda_function" "importer" {
  # checkov:skip=CKV_AWS_50:skipping
  filename         = "../../resources/hello-world.zip"
  function_name    = var.name_prefix
  role             = aws_iam_role.importer.arn
  handler          = "src/import.lambda_handler"
  source_code_hash = filebase64sha256("../../resources/hello-world.zip")
  layers           = [aws_lambda_layer_version.dependencies.arn]
  timeout          = 60

  runtime = "python3.8"

  environment {
    variables = {
      API_URL = var.api_url
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
      layers,
      last_modified
    ]
  }
}

resource "aws_lambda_layer_version" "dependencies" {
  filename   = "../../resources/hello-world.zip"
  layer_name = "${var.name_prefix}-dependencies"

  compatible_runtimes = ["python3.8"]
}

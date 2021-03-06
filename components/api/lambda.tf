resource "aws_lambda_function" "api" {
  # checkov:skip=CKV_AWS_50:skipping
  filename         = "../../resources/hello-world.zip"
  function_name    = var.name_prefix
  role             = aws_iam_role.api.arn
  handler          = "start_lambda.http_server"
  source_code_hash = filebase64sha256("../../resources/hello-world.zip")
  layers           = [aws_lambda_layer_version.dependencies.arn]
  timeout          = 3

  runtime = "python3.8"

  environment {
    variables = {
      TABLE_NAME   = data.aws_dynamodb_table.hzs.name
      DYNAMODB_URL = ""
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

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

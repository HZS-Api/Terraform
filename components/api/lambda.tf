resource "aws_lambda_function" "api" {
  # checkov:skip=CKV_AWS_50:skipping
  filename         = "../../resources/hello-world.zip"
  function_name    = var.name_prefix
  role             = aws_iam_role.api.arn
  handler          = "src/app.main"
  source_code_hash = filebase64sha256("../../resources/hello-world.zip")
  layers           = [aws_lambda_layer_version.dependencies.arn]

  runtime = "python3.8"

  tags = var.tags
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

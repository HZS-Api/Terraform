resource "aws_cloudwatch_event_rule" "every_day" {
  name                = "${var.name_prefix}-every-day"
  description         = "Fires every day"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "run_lambda_every_day" {
  rule      = aws_cloudwatch_event_rule.every_day.name
  target_id = "lambda"
  arn       = aws_lambda_function.importer.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.importer.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_day.arn
}

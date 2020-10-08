data "aws_iam_role" "api_lambda" {
  name = var.lambda_iam_role_name
}

data "aws_iam_policy_document" "access_to_dynamo_db" {
  version = "2012-10-17"

  statement {
    sid = "DynamodbAccess"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.dynamodb.arn]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.name_prefix}-dynamodb"
  path   = "/"
  policy = data.aws_iam_policy_document.access_to_dynamo_db.json
}

resource "aws_iam_role_policy_attachment" "db" {
  role       = data.aws_iam_role.api_lambda.name
  policy_arn = aws_iam_policy.policy.arn
}

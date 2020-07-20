resource "aws_iam_role" "iam_lambda" {
  name = var.name_prefix

  assume_role_policy = data.aws_iam_policy_document.iam_lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "iam_lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

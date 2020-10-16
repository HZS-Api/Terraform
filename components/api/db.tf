data "aws_dynamodb_table" "hzs" {
  name = var.dynamodb_table_name
}

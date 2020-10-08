resource "aws_dynamodb_table" "dynamodb" {
  name         = var.name_prefix
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "incidents_uuid"

  attribute {
    name = "incidents_uuid"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [ttl]
  }
}

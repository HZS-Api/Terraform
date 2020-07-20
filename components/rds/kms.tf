resource "aws_kms_key" "rds" {
  description             = "This key is used to encrypt RDS database at rest"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
}

resource "aws_kms_alias" "rds" {
  name          = "alias/${var.name_prefix}"
  target_key_id = aws_kms_key.rds.key_id
}

resource "random_string" "password" {
  length  = 16
  special = true
}

resource "aws_db_instance" "rds" {
  allocated_storage         = var.allocated_storage
  storage_type              = "gp2"
  engine                    = "postgres"
  engine_version            = "11.6"
  instance_class            = var.instance_class
  identifier                = var.name_prefix
  name                      = var.name_prefix
  username                  = "postgres"
  password                  = random_string.password.result # Will be changed manually
  kms_key_id                = aws_kms_key.rds.arn
  final_snapshot_identifier = var.name_prefix
  storage_encrypted         = true
  tags                      = var.tags
}

locals {
  rds_secrets = {
    password = random_string.password.result
    username = aws_db_instance.rds.username
    host     = aws_db_instance.rds.endpoint
  }
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "${var.name_prefix}-rds-password"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = jsonencode(local.rds_secrets)
}

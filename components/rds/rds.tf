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
  name                      = var.name_prefix
  username                  = "postgres"
  password                  = random_string.password.result # Will be changed manually
  kms_key_id                = aws_kms_key.rds.arn
  final_snapshot_identifier = var.name_prefix
  storage_encrypted         = true
  tags                      = var.tags
}

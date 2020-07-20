resource "random_string" "password" {
  length = 16
  special = true
}

resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.6"
  instance_class       = var.instance_class
  name                 = var.name_prefix
  username             = "postgres"
  password             = random_string.password.result # Will be changed manually
  tags = var.tags
}

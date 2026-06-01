resource "aws_secretsmanager_secret" "db" {
  name = var.secret_name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    DATABASE_URL = var.secret_value
  })
}

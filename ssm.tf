# DB Password
resource "random_password" "db" {
  length  = 20
  special = false
}

resource "aws_ssm_parameter" "db_password" {
  name  = "db_password"
  type  = "SecureString"
  value = random_password.db.result
}

resource "aws_ssm_parameter" "db_user" {
  name  = "db_user"
  type  = "String"
  value = aws_db_instance.app_db.username
}
resource "aws_ssm_parameter" "db_address" {
  name  = "db_address"
  type  = "String"
  value = aws_db_instance.app_db.address
}


resource "aws_ssm_parameter" "ecr_repo_name" {
  name  = "ecr_repo_name"
  type  = "String"
  value = aws_ecr_repository.ecr.name
}

resource "aws_ssm_parameter" "ecr_registry_url" {
  name  = "ecr_registry_url"
  type  = "String"
  value = aws_ecr_repository.ecr.repository_url
}

resource "aws_ssm_parameter" "cluster_name" {
  name  = "cluster_name"
  type  = "String"
  value = module.eks.cluster_id
}

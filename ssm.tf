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

resource "aws_ssm_parameter" "ecr_repo_name" {
  name  = "ecr_repo_name"
  type  = "String"
  value = aws_ecr_repository.ecr.name
}

resource "aws_ssm_parameter" "cluster_name" {
  name  = "cluster_name"
  type  = "String"
  value = module.eks.cluster_id
}

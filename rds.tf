# Create RDS subnet group
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  name       = var.db_subnet_grp
  subnet_ids = aws_subnet.private_db_subnets.*.id
}

resource "random_password" "db" {
  length  = 20
  special = false
}

resource "aws_ssm_parameter" "db_password" {
  name  = "db_password"
  type  = "SecureString"
  value = random_password.db.result
}
# Create RDS instance
resource "aws_db_instance" "app_db" {
  identifier              = var.primary_rds_identifier
  availability_zone       = var.az[0]
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "8.0.32"
  instance_class          = var.db_instance_type
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.RDS_subnet_grp.name
  vpc_security_group_ids  = [aws_security_group.db_server_sg.id]
  db_name                 = var.database_name
  username                = var.database_user
  password                = "parola12345"#random_password.db.result
  skip_final_snapshot     = true
  backup_retention_period = 7
}

# # Create RDS instance replica
# resource "aws_db_instance" "app_db_replica" {
#   replicate_source_db    = var.primary_rds_identifier
#   identifier             = var.replica_rds_identifier
#   availability_zone      = var.az[1]
#   allocated_storage      = 10
#   engine                 = "mysql"
#   engine_version         = "8.0.32"
#   instance_class         = var.db_instance_type
#   storage_type           = "gp2"
#   vpc_security_group_ids = [aws_security_group.db_server_sg.id]
#   skip_final_snapshot    = true

#   depends_on = [aws_db_instance.app_db]
# }

# Security group for database servers
resource "aws_security_group" "db_server_sg" {
  name        = "db-server-SG"
  description = "Allow inbound SSH traffic for instances in database tier"
  vpc_id      = aws_vpc.project_vpc.id
}

# Give application servers access to database servers
resource "aws_security_group_rule" "db_server_mysql_rule" {
  security_group_id        = aws_security_group.db_server_sg.id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.eks.node_security_group_id
}

# Allow outbound traffic
resource "aws_security_group_rule" "db_server_outbound_rule" {
  security_group_id = aws_security_group.db_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

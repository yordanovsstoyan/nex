aws_region = "us-east-2"

vpc_name = "project-vpc"
vpc_cidr = "172.20.0.0/20"

# Subnets availability zones
az = ["us-east-2a", "us-east-2b"]

public_subnets_cidr = ["172.20.1.0/24", "172.20.2.0/24"]
private_app_subnets_cidr = ["172.20.3.0/24", "172.20.4.0/24"]
private_db_subnets_cidr = ["172.20.5.0/24", "172.20.6.0/24"]


db_subnet_grp = "wordpress-db-subnet-grp" # RDS subnet group name
primary_rds_identifier = "rds-instance"
replica_rds_identifier = "rds-instance-replica"
db_instance_type = "db.t3.micro"
db_storage = "10"
db_engine = "mysql"
db_engine_version = "8.0.32"
database_name = "alex"
database_user = "dbuser"

# ECR repository name
ecr_name = "mysql-connect-app"

# EKS cluster name
cluster_name = "my-eks-cluster"
cluster_version = 1.25

general_node_group_desired_size    = 1
general_node_group_min_size        = 1
general_node_group_max_size        = 2
general_node_group_instance_types  = ["t3.small"]

spot_node_group_desired_size    = 1
spot_node_group_min_size        = 1
spot_node_group_max_size        = 2
spot_node_group_instance_types  = ["t3.micro"]

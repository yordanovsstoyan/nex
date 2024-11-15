# AWS region
variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "aws region"
}

# VPC name
variable "vpc_name" {
  type        = string
  default     = "project-vpc"
  description = "name of VPC"
}

# VPC CIDR
variable "vpc_cidr" {
  type        = string
  default     = "172.20.0.0/20"
  description = "VPC CIDR block"
}

# Public subnets CIDR list
variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.1.0/24", "172.20.2.0/24"]
  description = "public subnets CIDR"
}

# Private app subnets CIDR list
variable "private_app_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.3.0/24", "172.20.4.0/24"]
  description = "private app subnets CIDR"
}

# Private db subnets CIDR list
variable "private_db_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.5.0/24", "172.20.6.0/24"]
  description = "private database subnets CIDR"
}

# Subnets availability zones
variable "az" {
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
  description = "availability zones"
}

# RDS subnet group name
variable "db_subnet_grp" {
  type        = string
  default     = "wordpress-db-subnet-grp"
  description = "name of RDS subnet group"
}

# RDS primary instance identity
variable "primary_rds_identifier" {
  type        = string
  default     = "rds-instance"
  description = "Identifier of primary RDS instance"
}

# RDS replica identity
variable "replica_rds_identifier" {
  type        = string
  default     = "rds-instance-replica"
  description = "Identifier of replica RDS instance"
}

# Type of RDS instance
variable "db_instance_type" {
  type        = string
  default     = "db.t3.micro"
  description = "type/class of RDS database instance"
}
variable "db_storage" {
  type        = string
  default     = "10"
  description = "Allocated Storage For DB"
}
variable "db_engine" {
  type        = string
  default     = "mysql"
  description = "Database Engine"
}
variable "db_engine_version" {
  type        = string
  default     = "8.0.32"
  description = "Database Engine Version"
}
# RDS instance name
variable "database_name" {
  type        = string
  default     = "alex"
  description = "name of RDS DB"
}

# RDS instance username
variable "database_user" {
  type        = string
  description = "name of RDS instance user"
  default     = "dbuser"
}

variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
  description = "name of EKS Cluster"
}

variable "cluster_version" {
  type    = number
  default = 1.25
  description = "Kubernetes Version"
}

variable "ecr_name" {
  type    = string
  default = "mysql-connect-app"
  description = "ECR Repo Name"
}

variable "general_node_group_desired_size" {
  type        = number
  default     = 1
  description = "Desired number of instances for the general node group."
}

variable "general_node_group_min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances for the general node group."
}

variable "general_node_group_max_size" {
  type        = number
  default     = 2
  description = "Maximum number of instances for the general node group."
}

variable "general_node_group_instance_types" {
  type        = list(string)
  default     = ["t3.small"]
  description = "Instance types for the general node group."
}

variable "spot_node_group_desired_size" {
  type        = number
  default     = 1
  description = "Desired number of instances for the spot node group."
}

variable "spot_node_group_min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances for the spot node group."
}

variable "spot_node_group_max_size" {
  type        = number
  default     = 2
  description = "Maximum number of instances for the spot node group."
}

variable "spot_node_group_instance_types" {
  type        = list(string)
  default     = ["t3.micro"]
  description = "Instance types for the spot node group."
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = aws_vpc.project_vpc.id
  subnet_ids = aws_subnet.private_app_subnets[*].id

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 20
  }

  eks_managed_node_groups = {
    general = {
      desired_size = var.general_node_group_desired_size
      min_size     = var.general_node_group_min_size 
      max_size     = var.general_node_group_max_size

      labels = {
        role = "general"
      }

      instance_types = var.general_node_group_instance_types
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      desired_size = var.spot_node_group_desired_size 
      min_size     = var.spot_node_group_min_size
      max_size     = var.spot_node_group_max_size

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = var.spot_node_group_instance_types
      capacity_type  = "SPOT"
    }
  }

  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    },
    metrics_server_ingress = {
      description                   = "communication between control plane and the metrics-server endpoint"
      protocol                      = "tcp"
      from_port                     = "4443"
      to_port                       = "4443"
      type                          = "ingress"
      source_cluster_security_group = true
    },
    metrics_server_pod_ingress = {
      description = "communication between the metrics-server pod and the kubelet running on each worker node"
      protocol    = "tcp"
      from_port   = "10250"
      to_port     = "10250"
      type        = "ingress"
      self        = true
    }
  }


  tags = {
    Environment = "dev"
  }
}
resource "aws_security_group_rule" "eks_rds_ingress" {
  security_group_id        = module.eks.node_security_group_id
  type                     = "ingress"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.db_server_sg.id
}
resource "aws_security_group_rule" "eks_rds_egress" {
  security_group_id        = module.eks.node_security_group_id
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.db_server_sg.id
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

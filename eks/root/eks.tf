module "app_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name    = var.eks.cluster_name
  cluster_version = var.eks.cluster_version

  vpc_id     = data.aws_vpc.vpc[0].id
  subnet_ids = local.cluster_subnets

  cluster_endpoint_public_access  = var.eks.cluster_endpoint_public_access
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = var.eks.cluster_endpoint_public_access_cidrs

  cluster_enabled_log_types              = ["authenticator", "api", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = var.eks.log_group_retention

  # cluster_encryption_config = {
  #   provider_key_arn = data.aws_kms_key.eks_kms.arn
  #   resources        = ["secrets"]
  # }
  
  kms_key_administrators = var.eks.kms_key_administrators
  kms_key_owners = var.eks.kms_key_owners
  
  node_security_group_enable_recommended_rules = var.eks.node_security_group_enable_recommended_rules ? true : var.eks.node_security_group_enable_recommended_rules
  
  create_iam_role          = var.eks.create_iam_role
  iam_role_arn             = var.eks.create_iam_role ? null : var.eks.iam_role_arn
  iam_role_name            = var.eks.iam_role_name
  iam_role_use_name_prefix = false
  iam_role_description     = "EKS managed node group role"
  iam_role_tags = {
    Name    = var.eks.iam_role_name
    Purpose = "Protector of the kubelet"
  }
  iam_role_additional_policies = {
    additional = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
  enable_irsa = var.eks.enable_irsa

  cluster_security_group_additional_rules = var.eks.cluster_security_group_additional_rules

  ## EKS CLuster 
  node_security_group_additional_rules = var.eks.node_security_group_additional_rules

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type   = "AL2_x86_64"
    # subnet_ids = local.node_subnets
    
    instance_types = ["c6i.4xlarge"]
  }

  eks_managed_node_groups = local.node_groups
  
  manage_aws_auth_configmap = true

  aws_auth_roles = var.eks.aws_auth_roles
  aws_auth_users = var.eks.aws_auth_users

  tags = var.eks.tags
}

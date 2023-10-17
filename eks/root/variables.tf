variable aws {
    type = object({
        region  = string
        profile = string
    })
}

variable "vpc" {
    description = "VPC Configuration"
    type        = object({
        is_exists   = bool
        vpc_name    = string
        cluster_subnets    = list(string)
    })
}

variable "eks" {
    description = "EKS Configuration"
    type        = object({
        // Base
        cluster_name                    = string
        cluster_version                 = string

        cluster_endpoint_public_access = bool
        cluster_endpoint_public_access_cidrs = list(string)

        log_group_retention = number

        create_iam_role = bool
        iam_role_arn = string
        iam_role_name = string

        kms_key_administrators = list(string)
        kms_key_owners = list(string)

        node_security_group_enable_recommended_rules = bool

        enable_irsa = bool

        // SecurityGroups
        cluster_security_group_additional_rules = any

        node_security_group_additional_rules = any

        aws_auth_roles = list(any)
        aws_auth_users = list(any)

        // Nodes
        node_groups = any

        tags = map(string)
    })
}
aws = {
    "region" = "ap-northeast-2"
    "profile" = "nextsdp"
}

vpc = {
    is_exists = true
    vpc_name = "VPC-DEV-HEE"
    cluster_subnets = ["SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE","SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"]
}

eks = {
    // Base

    cluster_name = "EKS-AN2-DEV-HEE"
    cluster_version = "1.28"

    cluster_endpoint_public_access  = false
    cluster_endpoint_public_access_cidrs = []

    log_group_retention = 5
    iam_role_arn = null
    create_iam_role = true
    iam_role_name = "ROLE-DEV-HEE-EKS-NODE"

    kms_key_administrators = []
    kms_key_owners = []

    node_security_group_enable_recommended_rules = false

    enable_irsa = true

    // SecurityGroups
    cluster_security_group_additional_rules = {
        ingress_private = {
            description = "To cluster 443 from private network"
            protocol    = "tcp"
            from_port   = 443
            to_port     = 443
            type        = "ingress"
            cidr_blocks = ["100.64.0.0/22"]
        }
    }

    node_security_group_additional_rules = {
        ingress_self_all = {
            description = "Node to node all ports/protocols"
            protocol    = "-1"
            from_port   = 0
            to_port     = 0
            type        = "ingress"
            self        = true
        }

        ingress_solution_webhook = {
            description = "Cluster API to Node all allow"
            protocol    = "tcp"
            from_port   = 1025
            to_port     = 65535
            type        = "ingress"
            cidr_blocks = ["100.64.0.0/22"]
        }

        egress_http = {
            description = "Node all egress"
            protocol    = "tcp"
            from_port   = 80
            to_port     = 80
            type        = "egress"
            cidr_blocks = ["0.0.0.0/0"]
        }

        egress_https = {
            description = "Node all egress"
            protocol    = "tcp"
            from_port   = 443
            to_port     = 443
            type        = "egress"
            cidr_blocks = ["0.0.0.0/0"]
        }

        egress_mgmt = {
            description = "Node to Cluster webhook"
            protocol    = "tcp"
            from_port   = 1025
            to_port     = 65535
            type        = "egress"
            cidr_blocks = ["100.64.0.0/22"]
        }

        egress_dns_tcp = {
            description = "Node to DNS TCP"
            protocol    = "tcp"
            from_port   = 53
            to_port     = 53
            type        = "egress"
            cidr_blocks = ["0.0.0.0/0"]
        }

        egress_dns_udp = {
            description = "Node to DNS UDP"
            protocol    = "udp"
            from_port   = 53
            to_port     = 53
            type        = "egress"
            cidr_blocks = ["0.0.0.0/0"]
        }

    }

    // AWS_AUTHs
    aws_auth_roles                         = []
    aws_auth_users                         = []

    node_groups = {}

    tags = {
        "Name" = "EKS-AN2-DEV-HEE"
        "k8s.io/cluster-autoscaler/enabled" = 1
        "k8s.io/cluster-autoscaler/EKS-AN2-DEV-HEE" = 1
        "Billing"   = "hee"
    }
}
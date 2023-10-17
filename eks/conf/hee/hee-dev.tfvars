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

    cluster_endpoint_public_access  = true
    cluster_endpoint_public_access_cidrs = ["27.122.140.10/32"]

    log_group_retention = 5
    iam_role_arn = null
    create_iam_role = true
    iam_role_name = "ROLE-DEV-HEE-EKS-NODE"

    kms_key_administrators = [
        "arn:aws:iam::056231226580:user/hee"
        ]
    kms_key_owners = [
        "arn:aws:iam::056231226580:user/hee"
        ]

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
    aws_auth_users                         = [
        {
            userarn  = "arn:aws:iam::056231226580:user/hee"
            username = "hee"
            groups   = ["system:masters"]
        }
    ]

    node_groups = {
        EC2-AN2-DEV-HEE-NODE-MGMT = {
            ng_name = "EC2-AN2-DEV-HEE-NODE-MGMT"
            ami_type = "AL2_x86_64"
            subnet_ids = ["SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE","SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"]
            min_size       = 2
            max_size       = 3
            desired_size = 2
            instance_types = ["t3.large"]
            capacity_type = "ON_DEMAND"
            labels = {
                "System" = "MGMT"
            }

            iam_role_use_name_prefix   = false
            enable_bootstrap_user_data = false

            block_device_mappings = [
                {
                    device_name = "/dev/xvda"
                    ebs = {
                        encrypted = true
                        volume_size = 20
                        volume_type = "gp3"
                        kms_key_id = "arn:aws:kms:ap-northeast-2:058899106981:key/affe6c28-29ac-4c91-85cf-3f94785c34eb"
                    }
                }
            ]
            iam_role_additional_policies = {
            }
            tags = {
                "Billing"   = "hee"
            }
        },
        EC2-AN2-DEV-HEE-NODE-INGRESS = {
            ng_name = "EC2-AN2-DEV-HEE-NODE-INGRESS"
            ami_type = "AL2_x86_64"
            subnet_ids = ["SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE","SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"]
            min_size       = 1
            max_size       = 1
            desired_size = 1
            instance_types = ["t3.xlarge"]
            capacity_type = "ON_DEMAND"
            labels = {
                "System" = "INGRESS"
            }

            iam_role_use_name_prefix   = false
            enable_bootstrap_user_data = false

            block_device_mappings = [
                {
                    device_name = "/dev/xvda"
                    ebs = {
                        encrypted = true
                        volume_size = 20
                        volume_type = "gp3"
                        kms_key_id = "arn:aws:kms:ap-northeast-2:058899106981:key/affe6c28-29ac-4c91-85cf-3f94785c34eb"
                    }
                }
            ]

            iam_role_additional_policies = {
            }
            tags = {
                "Billing"   = "hee"
            }
        }
    }

    tags = {
        "Name" = "EKS-AN2-DEV-HEE"
        "k8s.io/cluster-autoscaler/enabled" = 1
        "k8s.io/cluster-autoscaler/EKS-AN2-DEV-HEE" = 1
        "Billing"   = "hee"
    }
}
data "aws_vpc" "vpc" {
    count   = var.vpc.is_exists ? 1 : 0
    filter {
        name = "tag:Name"
        values = [var.vpc.vpc_name]
    }
}

data "aws_subnet" "cluster_subnets" {
    for_each = toset(var.vpc.cluster_subnets)

    filter {
        name = "tag:Name"
        values = [each.value]
    }
}

data "aws_subnet" "node_subnets" {
    for_each = local.nodegroup_subnets

    filter {
        name = "tag:Name"
        values = [each.value]
    }
}

# data "aws_kms_key" "eks_kms" {
#   key_id = var.eks.kms_alias
# }

//data "aws_iam_role" "mgmt_role" {
//  name = var.eks.node_groups.mgmt_node.iam_role_name
//}

//data "aws_iam_role" "ingress_role" {
//  name = var.eks.node_groups.ingress_node.iam_role_name
//}
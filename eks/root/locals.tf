locals {
    cluster_subnets = concat([
        for subnet in var.vpc.cluster_subnets :
        data.aws_subnet.cluster_subnets[subnet].id
    ])
    
    # node_groups = {
    #     for nodegroup in var.eks.node_groups : nodegroup.ng_name => nodegroup
    # }
    
    nodegroup_subnets = toset(distinct(flatten([
        for nodegroup in var.eks.node_groups : nodegroup.subnet_ids
    ])))
    
    node_groups = {
        for nodegroup in flatten([
            for ng in var.eks.node_groups : {
                ng_name = ng.ng_name
                ami_type = ng.ami_type
                min_size       = ng.min_size
                max_size       = ng.max_size
                desired_size = ng.desired_size
                instance_types = ng.instance_types
                capacity_type = ng.capacity_type
                labels = ng.labels
                subnet_ids = concat([
                    for subnet in ng.subnet_ids :
                        data.aws_subnet.node_subnets[subnet].id
                ])
                iam_role_additional_policies = lookup(ng, "iam_role_additional_policies", {})
                iam_role_use_name_prefix   = ng.iam_role_use_name_prefix
                enable_bootstrap_user_data = ng.enable_bootstrap_user_data
                
                block_device_mappings = ng.block_device_mappings
                tags = ng.tags
            }
        ]) : nodegroup.ng_name => nodegroup
    }
}
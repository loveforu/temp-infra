resource "aws_default_network_acl" "default" {
    for_each                = var.vpcs
    default_network_acl_id  = aws_vpc.vpcs[each.key].default_network_acl_id
    tags                    = each.value.default_network_acl.tags
    subnet_ids              = (
        length(each.value.default_network_acl.subnets) != 1 ? 
            [
                for val in each.value.default_network_acl.subnets:
                    substr(val, 0, 7) == "subnet-" ? val : aws_subnet.subnets["${each.key}.${val}"].id
            ]
            : (
                each.value.default_network_acl.subnets[0] != "ALL" ? 
                    each.value.default_network_acl.subnets : [
                        for key, val in local.vpc_subnets: 
                            aws_subnet.subnets[key].id if val.vpc_name == each.key
                    ]
            )
    )

    dynamic ingress {
        for_each = toset(each.value.default_network_acl.ingresses)
        content {
            from_port       = ingress.value.from_port
            to_port         = ingress.value.to_port
            rule_no         = ingress.value.rule_no
            action          = ingress.value.action
            protocol        = ingress.value.protocol
            cidr_block      = ingress.value.cidr_block
            ipv6_cidr_block = ingress.value.ipv6_cidr_block
            icmp_type       = ingress.value.icmp_type
            icmp_code       = ingress.value.icmp_code
        }
    }

    dynamic egress {
        for_each = toset(each.value.default_network_acl.egresses)
        content {
            from_port       = egress.value.from_port
            to_port         = egress.value.to_port
            rule_no         = egress.value.rule_no
            action          = egress.value.action
            protocol        = egress.value.protocol
            cidr_block      = egress.value.cidr_block
            ipv6_cidr_block = egress.value.ipv6_cidr_block
            icmp_type       = egress.value.icmp_type
            icmp_code       = egress.value.icmp_code
        }
    }
}

resource "aws_network_acl" "network_acls" {
    for_each                = local.vpc_network_acls
    vpc_id                  = aws_vpc.vpcs[each.value.vpc_name].id
    tags                    = each.value.network_acl.tags
    subnet_ids              = (
        length(each.value.network_acl.subnets) != 1 ? 
            [
                for val in each.value.network_acl.subnets:
                    substr(val, 0, 7) == "subnet-" ? val : aws_subnet.subnets["${each.value.vpc_name}.${val}"].id
            ]
            : (
                each.value.network_acl.subnets[0] != "ALL" ? 
                    each.value.network_acl.subnets : [
                        for key, val in local.vpc_subnets: 
                            aws_subnet.subnets[key].id if val.vpc_name == each.key
                    ]
            )
    )

    dynamic ingress {
        for_each = toset(each.value.network_acl.ingresses)
        content {
            from_port       = ingress.value.from_port
            to_port         = ingress.value.to_port
            rule_no         = ingress.value.rule_no
            action          = ingress.value.action
            protocol        = ingress.value.protocol
            cidr_block      = ingress.value.cidr_block
            ipv6_cidr_block = ingress.value.ipv6_cidr_block
            icmp_type       = ingress.value.icmp_type
            icmp_code       = ingress.value.icmp_code
        }
    }

    dynamic egress {
        for_each = toset(each.value.network_acl.egresses)
        content {
            from_port       = egress.value.from_port
            to_port         = egress.value.to_port
            rule_no         = egress.value.rule_no
            action          = egress.value.action
            protocol        = egress.value.protocol
            cidr_block      = egress.value.cidr_block
            ipv6_cidr_block = egress.value.ipv6_cidr_block
            icmp_type       = egress.value.icmp_type
            icmp_code       = egress.value.icmp_code
        }
    }
}
variable aws {
    type = object({
        region  = string
        profile = string
    })
}

variable vpcs {
    type = map(object({

        cidr_blocks = list(string)

        instance_tenancy                  = string
        enable_dns_support                = bool
        enable_dns_hostnames              = bool
        enable_classiclink                = bool
        enable_classiclink_dns_support    = bool
        assign_generated_ipv6_cidr_block  = bool
        tags                              = map(string)

        internet_gateway                  = object({
            enable  = bool
            tags    = map(string)
        })

        nat_gateways                      = map(object({
            allocation_id   = string
            eip_prefix      = string
            subnet          = string
            tags            = map(string)
        }))

        dhcp_options                      = object({
            domain_name             = string
            domain_name_servers     = list(string)
            ntp_servers             = list(string)
            netbios_name_servers    = list(string)
            netbios_node_type       = number
            tags                    = map(string)
        })

        default_network_acl = object({
            subnets     = list(string)
            ingresses   = list(object({
                from_port       = number
                to_port         = number
                rule_no         = number
                action          = string
                protocol        = string
                cidr_block      = string
                ipv6_cidr_block = string
                icmp_type       = number
                icmp_code       = number
            }))
            egresses    = list(object({
                from_port       = number
                to_port         = number
                rule_no         = number
                action          = string
                protocol        = string
                cidr_block      = string
                ipv6_cidr_block = string
                icmp_type       = number
                icmp_code       = number
            }))
            tags        = map(string)
        })

        network_acls = map(object({
            subnets     = list(string)
            ingresses   = list(object({
                from_port       = number
                to_port         = number
                rule_no         = number
                action          = string
                protocol        = number
                cidr_block      = string
                ipv6_cidr_block = string
                icmp_type       = number
                icmp_code       = number
            }))
            egresses    = list(object({
                from_port       = number
                to_port         = number
                rule_no         = number
                action          = string
                protocol        = number
                cidr_block      = string
                ipv6_cidr_block = string
                icmp_type       = number
                icmp_code       = number
            }))
            tags        = map(string)
        }))

        subnets     = map(object({
            availability_zone               = string
            cidr_block                      = string
            ipv6_cidr_block                 = string
            map_public_ip_on_launch         = bool
            outpost_arn                     = string
            assign_ipv6_address_on_creation = bool
            tags                            = map(string)
        }))

        main_route_table = string

        default_route_table  = object({
            propagating_vgws    = list(string)
            tags                = map(string)
            routes              = list(tuple([string, string, string]))
            subnets             = list(string)
            gateways            = list(string)
        })

        route_tables = map(object({
            propagating_vgws    = list(string)
            tags                = map(string)
            routes              = list(tuple([string, string, string]))
            subnets             = list(string)
            gateways            = list(string)
        }))

    }))
}
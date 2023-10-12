locals {

    vpc_secondary_cidrs = flatten([
        for key, val in var.vpcs: [
            for v in slice(val.cidr_blocks, 1, length(val.cidr_blocks)): {
                key = key
                cidr_block = v
            }
        ]
    ])

    vpc_internet_gateways = {
        for key, val in var.vpcs: 
            key => val.internet_gateway if val.internet_gateway.enable
    }

    vpc_nat_gateways = {
        for nat_gateway in flatten([
            for key, val in var.vpcs: [
                for nat_gateway_name, nat_gateway in val.nat_gateways: {
                    vpc_name    = key
                    name        = nat_gateway_name
                    nat_gateway = nat_gateway
                }
            ]
        ]): "${nat_gateway.vpc_name}.${nat_gateway.name}" => nat_gateway
    }

    vpc_nat_ips = {
        for key, val in local.vpc_nat_gateways : key => val if val.nat_gateway.allocation_id == null
    }

    vpc_subnets = {
        for subnet in flatten([
            for key, val in var.vpcs: [
                for subnet_name, subnet in val.subnets: {
                    vpc_name    = key
                    name        = subnet_name
                    subnet      = subnet
                }
            ]
        ]): "${subnet.vpc_name}.${subnet.name}" => subnet
    }

    vpc_main_route_tables = {
        for main_route_table in [
            for key, val in var.vpcs: {
                vpc_name       = key
                route_table    = val.main_route_table
            }
        ]: main_route_table.vpc_name => main_route_table.route_table if main_route_table.route_table != null
    }

    vpc_route_tables = {
        for route_table in flatten([
            for key, val in var.vpcs: [
                for route_table_name, route_table in val.route_tables: {
                    vpc_name    = key
                    name        = route_table_name
                    route_table = route_table
                }
            ]
        ]): "${route_table.vpc_name}.${route_table.name}" => route_table
    }

    vpc_route_table_subnets = {
        for subnets in flatten([
            for key, val in var.vpcs: concat(
                [
                    for i, subnet in val.default_route_table.subnets: {
                        vpc_name         = key
                        route_table_name = "DEFAULT"
                        index            = i
                        subnet           = subnet
                    }
                ],
                flatten([
                    for route_table_name, route_table in val.route_tables: [
                        for i, subnet in route_table.subnets: {
                            vpc_name         = key
                            route_table_name = route_table_name
                            index            = i
                            subnet           = subnet
                        }
                    ]
                ])
            )
        ]): "${subnets.vpc_name}.${subnets.route_table_name}[${subnets.index}]" => subnets
    }

    vpc_network_acls = {
        for network_acl in flatten([
            for key, val in var.vpcs: [
                for network_acl_name, network_acl in val.network_acls: {
                    vpc_name    = key
                    name        = network_acl_name
                    network_acl = network_acl
                }
            ]
        ]): "${network_acl.vpc_name}.${network_acl.name}" => network_acl
    }
}
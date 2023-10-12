resource "aws_default_route_table" "default" {
    for_each                = var.vpcs
    default_route_table_id  = aws_vpc.vpcs[each.key].default_route_table_id
    propagating_vgws        = each.value.default_route_table.propagating_vgws
    tags                    = each.value.default_route_table.tags

    dynamic route {
        for_each = toset(each.value.default_route_table.routes)
        content {
            cidr_block                  = length(regexall(".", route.value[0])) == 0 ? "" : route.value[0]
            ipv6_cidr_block             = length(regexall(":", route.value[0])) == 0 ? "" : route.value[0]
            egress_only_gateway_id      = substr(route.value[1], 0, 4)     != "eigw" ? "" : route.value[1]
            gateway_id                  = (
                route.value[1] == "INTERNET" ? aws_internet_gateway.internet_gateways[each.key].id
                    : (
                        contains(["eigw", "nat-", "lgw-", "eni-", "tgw-", "pcx-"], substr(route.value[1], 0, 4)) || substr(route.value[1], 0, 2) == "i-" 
                            ? "" : route.value[1]
                    )
            )
            instance_id                 = substr(route.value[1], 0, 2)     != "i-"   ? "" : route.value[1]
            nat_gateway_id              = substr(route.value[1], 0, 4)     != "nat-" ? "" : route.value[1]
            network_interface_id        = (
                substr(route.value[1], 0, 4) == "eni-" ? route.value[1]
                    : (
                        substr(route.value[1], 0, 2) == "i-" && route.value[2] != null ? route.value[2] : ""
                    )
            )
            transit_gateway_id          = substr(route.value[1], 0, 4)     != "tgw-" ? "" : route.value[1]
            vpc_peering_connection_id   = substr(route.value[1], 0, 4)     != "pcx-" ? "" : route.value[1]
        }
    }
}

resource "aws_route_table" "route_tables" {
    for_each            = local.vpc_route_tables
    vpc_id              = aws_vpc.vpcs[each.value.vpc_name].id
    propagating_vgws    = each.value.route_table.propagating_vgws
    tags                = merge({ "Name" = each.value.name }, each.value.route_table.tags)

    dynamic route {
        for_each = toset(each.value.route_table.routes)
        content {
            cidr_block                  = length(regexall(".", route.value[0])) == 0 ? "" : route.value[0]
            ipv6_cidr_block             = length(regexall(":", route.value[0])) == 0 ? null : route.value[0]
            # cidr_block             = route.value[0]
            # ipv6_cidr_block             = route.value[0]
            egress_only_gateway_id      = substr(route.value[1], 0, 4)     != "eigw" ? "" : route.value[1]
            gateway_id                  = (
                route.value[1] == "INTERNET" ? aws_internet_gateway.internet_gateways[each.value.vpc_name].id
                    : (
                        contains(["eigw", "nat-", "lgw-", "eni-", "tgw-", "pcx-"], substr(route.value[1], 0, 4)) || substr(route.value[1], 0, 2) == "i-" || route.value[1] == "NEW NAT"
                            ? "" : route.value[1]
                    )
            )
            nat_gateway_id              = (
                route.value[1] == "NEW NAT" ? aws_nat_gateway.nat_gateways["${each.value.vpc_name}.${route.value[2]}"].id
                    : (
                        substr(route.value[1], 0, 4)     != "nat-" ? "" : route.value[1]
                    )
            )
            local_gateway_id            = substr(route.value[1], 0, 4)     != "lgw-" ? "" : route.value[1]
            network_interface_id        = (
                substr(route.value[1], 0, 4) == "eni-" ? route.value[1]
                    : (
                        substr(route.value[1], 0, 2) == "i-" && route.value[2] != null ? route.value[2] : ""
                    )
            )
            transit_gateway_id          = substr(route.value[1], 0, 4)     != "tgw-" ? "" : route.value[1]
            vpc_peering_connection_id   = substr(route.value[1], 0, 4)     != "pcx-" ? "" : route.value[1]
        }
    }

    depends_on = [ 
        aws_subnet.subnets
     ]

}

resource "aws_main_route_table_association" "main" {
    for_each        = local.vpc_main_route_tables
    vpc_id          = aws_vpc.vpcs[each.key].id
    route_table_id  = substr(each.value, 0, 4) == "rtb-" ? each.value : aws_route_table.route_tables["${each.key}.${each.value}"].id

    depends_on = [ 
        aws_route_table.route_tables
     ]
}

resource "aws_route_table_association" "subnets" {
    for_each        = local.vpc_route_table_subnets
    subnet_id       = length(each.value.subnet) < 7 || substr(each.value.subnet, 0, 7) != "subnet-" ? aws_subnet.subnets["${each.value.vpc_name}.${each.value.subnet}"].id: each.value.subnet
    route_table_id  = each.value.route_table_name == "DEFAULT" ? aws_vpc.vpcs[each.value.vpc_name].default_route_table_id : aws_route_table.route_tables["${each.value.vpc_name}.${each.value.route_table_name}"].id
    
    depends_on = [ 
        aws_route_table.route_tables
     ]
}

/*
resource "aws_route_table_association" "gateways" {
  gateway_id     = aws_internet_gateway.foo.id
  route_table_id = aws_route_table.bar.id
}
*/
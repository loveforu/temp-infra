output vpc {
    value = { 
        for key, val in aws_vpc.vpcs: 
            key => merge(val, { 
                internet_gateway    = lookup(aws_internet_gateway.internet_gateways, key, null)
                dhcp_options        = aws_vpc_dhcp_options.dhcp_options[key]
                subnets             = [
                    for subnet_key, subnet in local.vpc_subnets : aws_subnet.subnets[subnet_key] if subnet.vpc_name == key
                ]
            }) 
    }
}
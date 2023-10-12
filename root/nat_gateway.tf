resource "aws_eip" "nat_ips" {
    for_each    = local.vpc_nat_ips
    vpc         = true
    #tags        = merge({ "Name" = "${each.value.nat_gateway.eip_prefix == null ? "EIP" : each.value.nat_gateway.eip_prefix}_${each.value.name}" }, each.value.nat_gateway.tags)
    tags        = merge({Name = "${each.value.nat_gateway.eip_prefix == null ? format("EIP_${each.value.name}") : each.value.nat_gateway.eip_prefix}"}, each.value.nat_gateway.tags)
}

resource "aws_nat_gateway" "nat_gateways" {
    for_each        = local.vpc_nat_gateways
    allocation_id   = each.value.nat_gateway.allocation_id == null ? aws_eip.nat_ips[each.key].id : each.value.nat_gateway.allocation_id
    subnet_id       = substr(each.value.nat_gateway.subnet, 0, 7) != "subnet-" ? aws_subnet.subnets["${each.value.vpc_name}.${each.value.nat_gateway.subnet}"].id : each.value.nat_gateway.subnet

    tags = merge({ "Name" = each.value.name }, each.value.nat_gateway.tags)

    depends_on = [
        aws_subnet.subnets,
        aws_internet_gateway.internet_gateways
    ]
}
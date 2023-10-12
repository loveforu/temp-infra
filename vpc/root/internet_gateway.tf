resource "aws_internet_gateway" "internet_gateways" {
    for_each    = local.vpc_internet_gateways
    vpc_id      = aws_vpc.vpcs[each.key].id
    tags        = each.value.tags
}
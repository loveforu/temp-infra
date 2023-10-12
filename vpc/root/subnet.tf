resource "aws_subnet" "subnets" {
  for_each = local.vpc_subnets

  availability_zone               = length(regexall("-", each.value.subnet.availability_zone)) == 1 ? null : each.value.subnet.availability_zone
  availability_zone_id            = length(regexall("-", each.value.subnet.availability_zone)) == 2 ? null : each.value.subnet.availability_zone
  cidr_block                      = each.value.subnet.cidr_block
  ipv6_cidr_block                 = each.value.subnet.ipv6_cidr_block
  map_public_ip_on_launch         = each.value.subnet.map_public_ip_on_launch
  outpost_arn                     = each.value.subnet.outpost_arn
  assign_ipv6_address_on_creation = each.value.subnet.assign_ipv6_address_on_creation
  vpc_id                          = aws_vpc.vpcs[each.value.vpc_name].id
  tags                            = merge({ "Name" : each.value.name }, each.value.subnet.tags)

  depends_on = [
    aws_vpc.vpcs,
    aws_vpc_ipv4_cidr_block_association.secondary_cidrs
  ]
}
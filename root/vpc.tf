resource "aws_vpc" "vpcs" {

    for_each = var.vpcs

    cidr_block                        = each.value.cidr_blocks[0]
    instance_tenancy                  = each.value.instance_tenancy
    enable_dns_support                = each.value.enable_dns_support
    enable_dns_hostnames              = each.value.enable_dns_hostnames
    assign_generated_ipv6_cidr_block  = each.value.assign_generated_ipv6_cidr_block

    tags = merge({ Name = each.key }, each.value.tags)

    depends_on = [
        aws_vpc_dhcp_options.dhcp_options
    ]
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidrs" {

    count    = length(local.vpc_secondary_cidrs)

    vpc_id      = aws_vpc.vpcs[local.vpc_secondary_cidrs[count.index].key].id
    cidr_block  = local.vpc_secondary_cidrs[count.index].cidr_block

}
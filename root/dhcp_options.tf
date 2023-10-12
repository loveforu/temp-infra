resource "aws_vpc_dhcp_options" "dhcp_options" {

  for_each = var.vpcs

  domain_name          = each.value.dhcp_options.domain_name
  domain_name_servers  = each.value.dhcp_options.domain_name_servers
  ntp_servers          = each.value.dhcp_options.ntp_servers
  netbios_name_servers = each.value.dhcp_options.netbios_name_servers
  netbios_node_type    = each.value.dhcp_options.netbios_node_type
  tags                 = each.value.dhcp_options.tags

}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {

    for_each = var.vpcs

    vpc_id          = aws_vpc.vpcs[each.key].id
    dhcp_options_id = aws_vpc_dhcp_options.dhcp_options[each.key].id

}
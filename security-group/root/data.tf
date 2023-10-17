data "aws_vpc" "sg_vpc" {
    for_each = var.security_groups
    filter {
        name = "tag:Name"
        values = [each.value.vpc_name]
    }
}
aws = {
    region = "us-east-1"
    profile = "default"
}

vpcs = {
    "VPC-BEDROCK-POC" = {
        cidr_blocks                       = ["172.16.0.0/25", "100.64.0.0/22"]
        instance_tenancy                  = "default"
        enable_dns_support                = true
        enable_dns_hostnames              = true
        enable_classiclink                = false
        enable_classiclink_dns_support    = false
        assign_generated_ipv6_cidr_block  = false

        "tags" = {
            "Name"      = "VPC-BEDROCK-POC"
            "Service"   = ""
            "Stage"     = "BEDROCK"
            "Billing"   = "poc"
        } # End Of tags

        internet_gateway = {
            enable  = true
            "tags"    = {
                "Name"    = "IGW-BEDROCK-POC"
                "Service" = ""
                "Stage"   = "BEDROCK"
                "Billing" = "poc"
            }
        } # End Of internet_gateway

        nat_gateways = {
            "NAT-BEDROCK-POC-1" = {
                allocation_id = null
                eip_prefix = null
                subnet = "SBN-BEDROCK-PUBLIC-AZ2A-POC"
                tags = {
                    "Name" = "NAT-BEDROCK-POC-1"
                    "Stage" = "BEDROCK"
                    "Billing" = "poc"
                }
            }

            "NAT-BEDROCK-POC-2" = {
                allocation_id = null
                eip_prefix = null
                subnet = "SBN-BEDROCK-PUBLIC-AZ2C-POC"
                tags = {
                    "Name" = "NAT-BEDROCK-POC-2"
                    "Stage" = "BEDROCK"
                    "Billing" = "poc"
                }
            }
        } # End Of nat_gateways

        dhcp_options                      = {
            domain_name             = "ap-northeast-2.compute.internal"
            domain_name_servers     = ["AmazonProvidedDNS"]
            ntp_servers             = null
            netbios_name_servers    = null
            netbios_node_type       = null
            tags                    = {}
        } # End Of dhcp_options

        default_network_acl = {
            subnets     = [
                # "SBN-BEDROCK-TGW-PRIVATE-AZ2A",
                # "SBN-BEDROCK-TGW-PRIVATE-AZ2C",
                "SBN-BEDROCK-PUBLIC-AZ2A-POC",
                "SBN-BEDROCK-PUBLIC-AZ2C-POC",
                "SBN-BEDROCK-AP-PRIVATE-AZ2A-POC",
                "SBN-BEDROCK-AP-PRIVATE-AZ2C-POC",
                "SBN-BEDROCK-DB-PRIVATE-AZ2A-POC",
                "SBN-BEDROCK-DB-PRIVATE-AZ2C-POC"
            ]
            ingresses   = [
                {
                    from_port       = 0
                    to_port         = 0
                    rule_no         = 100
                    action          = "allow"
                    protocol        = "-1"
                    cidr_block      = "0.0.0.0/0"
                    ipv6_cidr_block = null
                    icmp_type       = 0
                    icmp_code       = 0
                }
            ]
            egresses    = [
                {
                    from_port       = 0
                    to_port         = 0
                    rule_no         = 100
                    action          = "allow"
                    protocol        = "-1"
                    cidr_block      = "0.0.0.0/0"
                    ipv6_cidr_block = null
                    icmp_type       = 0
                    icmp_code       = 0
                }
            ]
            tags        = {}
        } # End Of default_network_acl

        network_acls = {} # End Of network_acls

        subnets     = {

            # "SBN-BEDROCK-TGW-PRIVATE-AZ2A" = {
            #     availability_zone               = "ap-northeast-2a"
            #     cidr_block                      = "100.64.3.64/28"
            #     ipv6_cidr_block                 = null
            #     map_public_ip_on_launch         = false
            #     outpost_arn                     = null
            #     assign_ipv6_address_on_creation = false
            #     tags                            = {
            #         "Name"      = "SBN-BEDROCK-TGW-PRIVATE-AZ2A"
            #         "Service"   = ""
            #         "Stage"     = "BEDROCK"
            #         "Billing"   = "poc"
            #     }
            # }

            # "SBN-BEDROCK-TGW-PRIVATE-AZ2C" = {
            #     availability_zone               = "ap-northeast-2c"
            #     cidr_block                      = "100.64.3.80/28"
            #     ipv6_cidr_block                 = null
            #     map_public_ip_on_launch         = false
            #     outpost_arn                     = null
            #     assign_ipv6_address_on_creation = false
            #     tags                            = {
            #         "Name"      = "SBN-BEDROCK-TGW-PRIVATE-AZ2C"
            #         "Service"   = ""
            #         "Stage"     = "BEDROCK"
            #         "Billing"   = "poc"
            #     }
            # }

            "SBN-BEDROCK-PUBLIC-AZ2A-POC" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "100.64.3.0/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-PUBLIC-AZ2A-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                }
            }

            "SBN-BEDROCK-PUBLIC-AZ2C-POC" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "100.64.3.32/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-PUBLIC-AZ2C-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                }
            }

            "SBN-BEDROCK-AP-PRIVATE-AZ2A-POC" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "172.16.0.0/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-AP-PRIVATE-AZ2A-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                    "kubernetes.io/cluster/EKS-BEDROCK-POC" = "shared"
                    "kubernetes.io/role/internal-elb"    = "1"
                }
            }

            "SBN-BEDROCK-AP-PRIVATE-AZ2C-POC" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "172.16.0.32/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-AP-PRIVATE-AZ2C-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                    "kubernetes.io/cluster/EKS-BEDROCK-POC" = "shared"
                    "kubernetes.io/role/internal-elb"    = "1"
                }
            }

            "SBN-BEDROCK-DB-PRIVATE-AZ2A-POC" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "172.16.0.64/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-DB-PRIVATE-AZ2A-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                }
            }

            "SBN-BEDROCK-DB-PRIVATE-AZ2C-POC" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "172.16.0.96/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-BEDROCK-DB-PRIVATE-AZ2C-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                }
            }

        } # End Of subnets

        main_route_table = null

        default_route_table = {
            propagating_vgws    = [] # End Of propagating_vgws
            tags                = {} # End of tags
            routes              = [] # End Of routes
            subnets             = [] # End of subnets
            gateways            = [] # End Of gateways
        }

        route_tables = {

            "RT-BEDROCK-PUB-POC" = {
                propagating_vgws    = [] # End Of propagating_vgws
                tags                = {
                    "Name"      = "RT-BEDROCK-PUB-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "INTERNET", null],
                ] # End Of routes
                subnets             = [
                    "SBN-BEDROCK-PUBLIC-AZ2A-POC",
                    "SBN-BEDROCK-PUBLIC-AZ2C-POC"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-BEDROCK-PUB

            # "RT-BEDROCK-TGW" = {
            #     propagating_vgws    = [] # End Of propagating_vgws
            #     tags                = {
            #         "Name"      = "HTSPOC-BEDROCK-RT-TGW"
            #         "Service"   = ""
            #         "Stage"     = "BEDROCK"
            #         "Billing"   = "poc"
            #     } # End of tags
            #     routes              = [
            #         ["0.0.0.0/0", "NEW NAT", "HTSPOC-BEDROCK-NAT-1"]
            #     ] # End Of routes
            #     subnets             = [
            #         "SBN-BEDROCK-TGW-PRIVATE-AZ2A",
            #         "SBN-BEDROCK-TGW-PRIVATE-AZ2C",
            #     ] # End Of subnets
            #     gateways            = [] # End Of gateways
            # } # End Of RT-BEDROCK-PUB

            "RT-BEDROCK-PRIV-1-POC" = {
                propagating_vgws    = [] # End of propagating_vgws
                tags                = {
                    "Name"      = "RT-BEDROCK-PRIV-1-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "NEW NAT", "NAT-BEDROCK-POC-1"]
                ] # End Of routes
                subnets             = [
                    "SBN-BEDROCK-AP-PRIVATE-AZ2A-POC",
                    "SBN-BEDROCK-DB-PRIVATE-AZ2A-POC"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-BEDROCK-PRIV-1

            "RT-BEDROCK-PRIV-2-POC" = {
                propagating_vgws    = [] # End of propagating_vgws
                tags                = {
                    "Name"      = "RT-BEDROCK-PRIV-2-POC"
                    "Service"   = ""
                    "Stage"     = "BEDROCK"
                    "Billing"   = "poc"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "NEW NAT", "NAT-BEDROCK-POC-2"]
                ] # End Of routes
                subnets             = [
                    "SBN-BEDROCK-AP-PRIVATE-AZ2C-POC",
                    "SBN-BEDROCK-DB-PRIVATE-AZ2C-POC"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-BEDROCK-PRIV-2

        } # End Of route_tables

    } # End Of VPC-BEDROCK
}
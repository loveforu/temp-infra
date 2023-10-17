aws = {
    region = "ap-northeast-2"
    profile = "default"
}

vpcs = {
    "VPC-DEV-HEE" = {
        cidr_blocks                       = ["172.16.0.0/25", "100.64.0.0/22"]
        instance_tenancy                  = "default"
        enable_dns_support                = true
        enable_dns_hostnames              = true
        enable_classiclink                = false
        enable_classiclink_dns_support    = false
        assign_generated_ipv6_cidr_block  = false

        "tags" = {
            "Name"      = "VPC-DEV-HEE"
            "Service"   = ""
            "Stage"     = "DEV"
            "Billing"   = "hee"
        } # End Of tags

        internet_gateway = {
            enable  = true
            "tags"    = {
                "Name"    = "IGW-DEV-HEE"
                "Service" = ""
                "Stage"   = "DEV"
                "Billing" = "hee"
            }
        } # End Of internet_gateway

        nat_gateways = {
            "NAT-DEV-HEE-1" = {
                allocation_id = null
                eip_prefix = null
                subnet = "SBN-DEV-PUBLIC-AZ2A-HEE"
                tags = {
                    "Name" = "NAT-DEV-HEE-1"
                    "Stage" = "DEV"
                    "Billing" = "hee"
                }
            }

            "NAT-DEV-HEE-2" = {
                allocation_id = null
                eip_prefix = null
                subnet = "SBN-DEV-PUBLIC-AZ2C-HEE"
                tags = {
                    "Name" = "NAT-DEV-HEE-2"
                    "Stage" = "DEV"
                    "Billing" = "hee"
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
                # "SBN-DEV-TGW-PRIVATE-AZ2A",
                # "SBN-DEV-TGW-PRIVATE-AZ2C",
                "SBN-DEV-PUBLIC-AZ2A-HEE",
                "SBN-DEV-PUBLIC-AZ2C-HEE",
                "SBN-DEV-AP-PRIVATE-AZ2A-HEE",
                "SBN-DEV-AP-PRIVATE-AZ2C-HEE",
                "SBN-DEV-DB-PRIVATE-AZ2A-HEE",
                "SBN-DEV-DB-PRIVATE-AZ2C-HEE",
                "SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE",
                "SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"
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

            # "SBN-DEV-TGW-PRIVATE-AZ2A" = {
            #     availability_zone               = "ap-northeast-2a"
            #     cidr_block                      = "100.64.3.64/28"
            #     ipv6_cidr_block                 = null
            #     map_public_ip_on_launch         = false
            #     outpost_arn                     = null
            #     assign_ipv6_address_on_creation = false
            #     tags                            = {
            #         "Name"      = "SBN-DEV-TGW-PRIVATE-AZ2A"
            #         "Service"   = ""
            #         "Stage"     = "DEV"
            #         "Billing"   = "hee"
            #     }
            # }

            # "SBN-DEV-TGW-PRIVATE-AZ2C" = {
            #     availability_zone               = "ap-northeast-2c"
            #     cidr_block                      = "100.64.3.80/28"
            #     ipv6_cidr_block                 = null
            #     map_public_ip_on_launch         = false
            #     outpost_arn                     = null
            #     assign_ipv6_address_on_creation = false
            #     tags                            = {
            #         "Name"      = "SBN-DEV-TGW-PRIVATE-AZ2C"
            #         "Service"   = ""
            #         "Stage"     = "DEV"
            #         "Billing"   = "hee"
            #     }
            # }

            "SBN-DEV-PUBLIC-AZ2A-HEE" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "100.64.3.0/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-PUBLIC-AZ2A-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                }
            }

            "SBN-DEV-PUBLIC-AZ2C-HEE" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "100.64.3.32/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-PUBLIC-AZ2C-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                }
            }

            "SBN-DEV-AP-PRIVATE-AZ2A-HEE" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "172.16.0.0/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-AP-PRIVATE-AZ2A-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                    "kubernetes.io/cluster/EKS-DEV-HEE" = "shared"
                    "kubernetes.io/role/internal-elb"    = "1"
                }
            }

            "SBN-DEV-AP-PRIVATE-AZ2C-HEE" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "172.16.0.32/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-AP-PRIVATE-AZ2C-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                    "kubernetes.io/cluster/EKS-DEV-HEE" = "shared"
                    "kubernetes.io/role/internal-elb"    = "1"
                }
            }

            "SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "100.64.1.0/24"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                    "kubernetes.io/cluster/EKS-DEV-HEE" = "shared"
                }
            }

            "SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "100.64.2.0/24"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                    "kubernetes.io/cluster/EKS-DEV-HEE" = "shared"
                }
            }

            "SBN-DEV-DB-PRIVATE-AZ2A-HEE" = {
                availability_zone               = "ap-northeast-2a"
                cidr_block                      = "172.16.0.64/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-DB-PRIVATE-AZ2A-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                }
            }

            "SBN-DEV-DB-PRIVATE-AZ2C-HEE" = {
                availability_zone               = "ap-northeast-2c"
                cidr_block                      = "172.16.0.96/27"
                ipv6_cidr_block                 = null
                map_public_ip_on_launch         = false
                outpost_arn                     = null
                assign_ipv6_address_on_creation = false
                tags                            = {
                    "Name"      = "SBN-DEV-DB-PRIVATE-AZ2C-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
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

            "RT-DEV-PUB-HEE" = {
                propagating_vgws    = [] # End Of propagating_vgws
                tags                = {
                    "Name"      = "RT-DEV-PUB-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "INTERNET", null],
                ] # End Of routes
                subnets             = [
                    "SBN-DEV-PUBLIC-AZ2A-HEE",
                    "SBN-DEV-PUBLIC-AZ2C-HEE"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-DEV-PUB

            # "RT-DEV-TGW" = {
            #     propagating_vgws    = [] # End Of propagating_vgws
            #     tags                = {
            #         "Name"      = "HTSPOC-DEV-RT-TGW"
            #         "Service"   = ""
            #         "Stage"     = "DEV"
            #         "Billing"   = "hee"
            #     } # End of tags
            #     routes              = [
            #         ["0.0.0.0/0", "NEW NAT", "HTSPOC-DEV-NAT-1"]
            #     ] # End Of routes
            #     subnets             = [
            #         "SBN-DEV-TGW-PRIVATE-AZ2A",
            #         "SBN-DEV-TGW-PRIVATE-AZ2C",
            #     ] # End Of subnets
            #     gateways            = [] # End Of gateways
            # } # End Of RT-DEV-PUB

            "RT-DEV-PRIV-1-HEE" = {
                propagating_vgws    = [] # End of propagating_vgws
                tags                = {
                    "Name"      = "RT-DEV-PRIV-1-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "NEW NAT", "NAT-DEV-HEE-1"]
                ] # End Of routes
                subnets             = [
                    "SBN-DEV-AP-PRIVATE-AZ2A-HEE",
                    "SBN-DEV-DB-PRIVATE-AZ2A-HEE",
                    "SBN-DEV-EKS-POD-PRIVATE-AZ2A-HEE"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-DEV-PRIV-1

            "RT-DEV-PRIV-2-HEE" = {
                propagating_vgws    = [] # End of propagating_vgws
                tags                = {
                    "Name"      = "RT-DEV-PRIV-2-HEE"
                    "Service"   = ""
                    "Stage"     = "DEV"
                    "Billing"   = "hee"
                } # End of tags
                routes              = [
                    ["0.0.0.0/0", "NEW NAT", "NAT-DEV-HEE-2"]
                ] # End Of routes
                subnets             = [
                    "SBN-DEV-AP-PRIVATE-AZ2C-HEE",
                    "SBN-DEV-DB-PRIVATE-AZ2C-HEE",
                    "SBN-DEV-EKS-POD-PRIVATE-AZ2C-HEE"
                ] # End Of subnets
                gateways            = [] # End Of gateways
            } # End Of RT-DEV-PRIV-2

        } # End Of route_tables

    } # End Of VPC-DEV
}
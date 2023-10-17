aws = {
    region = "ap-northeast-2"
    profile = "default"
}

security_groups = {

    DEV-HEE-SG-ENDPOINT = {
        vpc_name = "VPC-DEV-HEE"
        description = "SG for DEV Endpoints"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [443, 443, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All DEV Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    DEV-HEE-SG-Maria = {
        vpc_name = "VPC-DEV-HEE"
        description = "SG for Maria in DEV"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [3306, 3306, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All DEV Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    DEV-HEE-SG-KAFKA = {
        vpc_name = "VPC-DEV-HEE"
        description = "SG for KAFKA in DEV"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [9092, 9092, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All DEV Private Resources", false],
            [9094, 9094, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All DEV Private Resources", false],
            [2181, 2181, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All DEV Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    DEV-HEE-SG-ElasticSearch = {
        vpc_name = "VPC-DEV-HEE"
        description = "SG for ElasticSearch in DEV"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [80, 80, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All DEV Private Resources", false],
            [443, 443, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All DEV Private Resources", false],
            [9020, 9020, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All DEV Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    DEV-HEE-SG-REDIS = {
        vpc_name = "VPC-DEV-HEE"
        description = "SG for REDIS in DEV"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [6379, 6379, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All DEV Private Resources", false]
        ]
        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    DEV-HEE-SG-XELB = {
        vpc_name = "VPC-DEV-HEE"
        description = "DEV-HEE-SG-IELB"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            [443, 443, "tcp", ["pl-22a6434b"], "Only CloudFront origin", false]
        ]

        egress = []
    }

    DEV-HEE-SG-XELB-EFS = {
        vpc_name = "VPC-DEV-HEE"
        description = "DEV-HEE-SG-XELB-EFS"
        tags = {
            "Billing"   = "hee"
        }
        ingress = [
            # prd private + privatepod subnet ab cidr
            [2049, 2049, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "Internal traffic", false]
        ]

        egress = []
    }

}
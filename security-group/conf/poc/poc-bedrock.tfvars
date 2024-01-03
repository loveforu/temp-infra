aws = {
    region = "us-east-1"
    profile = "default"
}

security_groups = {

    BEDROCK-POC-SG-ENDPOINT = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for BEDROCK Endpoints"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [443, 443, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    BEDROCK-POC-SG-DocumentDB = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for DocumentDB in BEDROCK"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [27017, 27017, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    BEDROCK-POC-SG-ElasticSearch = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for ElasticSearch in BEDROCK"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [9200, 9200, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    BEDROCK-POC-SG-ElasticSearch = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for ElasticSearch in BEDROCK"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [80, 80, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All BEDROCK Private Resources", false],
            [443, 443, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All BEDROCK Private Resources", false],
            [9020, 9020, "tcp", ["172.16.0.0/25", "100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]

        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    BEDROCK-POC-SG-REDIS = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for REDIS in BEDROCK"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [6379, 6379, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]
        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

    BEDROCK-POC-SG-KENDRA = {
        vpc_name = "VPC-BEDROCK-POC"
        description = "SG for KENDRA in BEDROCK"
        tags = {
            "Billing"   = "poc"
        }
        ingress = [
            [3306, 3306, "tcp", ["172.16.0.0/25","100.64.0.0/22"], "All BEDROCK Private Resources", false]
        ]
        egress = [
            [0, 0, "-1", ["0.0.0.0/0"], "", false]
        ]
    }

}
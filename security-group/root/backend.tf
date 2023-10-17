terraform {
  required_version = ">=0.13.0"

  backend "s3" {
    bucket = "s3-an2-nextsdp-shared-infrastate"
    key    = "nextsdp/ap-northeast-2/dev/terraform_nextsdp-dev_securitygroup.tfstate"
    region = "ap-northeast-2"
    encrypt       = true
  }
}

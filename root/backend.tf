terraform {
  required_version = ">=0.13.0"
  
  backend "s3" {
    bucket = "codepipeline-artifact-dev-hee-backend"
    key    = "hee/ap-northeast-2/dev/terraform_hee-dev_vpc.tfstate"
    region = "ap-northeast-2"
    # dynamodb_table = "codepipeline-artifact-dev-hee-backend"
    encrypt       = true
  }
}

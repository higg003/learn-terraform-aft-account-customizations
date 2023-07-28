module "vpc" {
  providers = {
    aws = local.us_deploment ? aws.us_region : aws.eu_region
  }
  source = "../modules/vpc"
  vpc_name = "${local.account_name}-us-vpc"
}
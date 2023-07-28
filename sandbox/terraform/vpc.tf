module "vpc" {
  providers = {
    aws = aws.us_region ? local.us_deploment : aws.eu_region
  }
  source = "../modules/vpc"
  vpc_name = "${local.account_name}-us-vpc"
}
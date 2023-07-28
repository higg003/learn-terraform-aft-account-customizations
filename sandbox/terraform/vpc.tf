module "vpc_us" {
  count = local.us_deployment ? 1 : 0

  providers = {
    aws = aws.us_region
  }

  source   = "../../modules/vpc/"
  vpc_name = "${local.account_name}-us-vpc"
}

module "vpc_eu" {
  count = local.us_deployment ? 0 : 1

  providers = {
    aws = aws.eu_region
  }

  source   = "../../modules/vpc/"
  vpc_name = "${local.account_name}-eu-vpc"
}
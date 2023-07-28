module "vpc_us" {

  providers = {
    aws = aws.us
  }

  source   = "../../modules/vpc"
  vpc_name = "${local.account_name}-us-vpc"

}

module "vpc_eu" {

  providers = {
    aws = aws.eu
  }

  source   = "../../modules/vpc"
  vpc_name = "${local.account_name}-eu-vpc"

}

moved {
  from = module.vpc
  to   = module.vpc_us
}
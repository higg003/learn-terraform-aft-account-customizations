module "vpc" {

  providers = {
    aws = aws.us
  }
  
  source   = "../../modules/vpc"
  vpc_name = "${local.account_name}-us-vpc"

}
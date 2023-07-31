module "vpc" {

  source   = "../../modules/vpc"
  aws_region = data.aws_region.current.name
  vpc_name = "${local.account_name}-eu-vpc"
  az_list  = ["eu-central-1a", "eu-central-1b"]
}
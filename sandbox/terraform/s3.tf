data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  providers = {
    aws = local.us_deploment ? aws.us_region : aws.eu_region
  }
  bucket = "aft-sandbox-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
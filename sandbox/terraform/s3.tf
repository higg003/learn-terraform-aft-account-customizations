data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  providers = {
    aws = aws.us_region ? local.us_deploment : aws.eu_region
  }
  bucket = "aft-sandbox-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
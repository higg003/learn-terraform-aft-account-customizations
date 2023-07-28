resource "aws_ssm_parameter" "foo" {
  providers = {
    aws = aws.us_region ? local.us_deploment : aws.eu_region
  }
  name  = "/accID"
  type  = "String"
  value = data.aws_caller_identity.current.account_id
}

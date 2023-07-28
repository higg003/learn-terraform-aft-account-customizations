resource "aws_ssm_parameter" "foo" {
  providers = {
    aws = local.us_deploment ? aws.us_region : aws.eu_region
  }
  name  = "/accID"
  type  = "String"
  value = data.aws_caller_identity.current.account_id
}

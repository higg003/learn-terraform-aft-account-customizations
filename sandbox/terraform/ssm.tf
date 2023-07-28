resource "aws_ssm_parameter" "foo" {

  providers = {
    aws = aws.us
  }

  name  = "/accID"
  type  = "String"
  value = data.aws_caller_identity.current.account_id
}
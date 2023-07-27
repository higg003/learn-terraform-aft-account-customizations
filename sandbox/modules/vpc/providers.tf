terraform {
  required_version = ">= 0.15.0"
}

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn    = "arn:aws:iam::187438746603:role/AWSAFTExecution"
  }
}
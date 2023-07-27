variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "value of the VPC name"
}

variable "az_list" {
  type        = list(string)
  description = "List of AZs to use for the VPC"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_cidr_block" {
  type        = string
  description = "value of the VPC CIDR block"
  default     = "172.31.99.0/24"
}

variable "app_subnet_cidr_block" {
  type        = list(string)
  description = "Values of the app subnet CIDR block"
  default     = ["172.31.99.0/27", "172.31.99.32/27"]
}

variable "rds_subnet_cidr_block" {
  type        = list(string)
  description = "Values of the app subnet CIDR block"
  default     = ["172.31.99.64/28", "172.31.99.80/28"]
}

variable "app_subnet_count" {
  type        = number
  description = "value of the app subnet count"
  default     = 2
}

variable "rds_subnet_count" {
  type        = number
  description = "value of the rds subnet count"
  default     = 2
}
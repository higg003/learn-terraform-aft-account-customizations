variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa|me|af)-(central|(north|south)?(east|west)?)-\\d", var.aws_region))
    error_message = "Variable var: region is not valid."
  }
}

variable "vpc_name" {
  type        = string
  description = "value of the VPC name"
  validation {
    condition     = length(var.vpc_name) > 0
    error_message = "Variable var: vpc_name cannot be empty."
  }
}

variable "az_list" {
  type        = list(string)
  description = "List of AZs to use for the VPC"
  default     = ["us-east-1a", "us-east-1b"]
  validation {
    condition     = contains(["us-east-1a", "us-east-1b", "eu-central-1a", "eu-central-1b"], var.az_list)
    error_message = "Valid values for var: az_list are (us-east-1a, us-east-1b, eu-central-1a and eu-central-1b)."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "value of the VPC CIDR block"
  default     = "172.31.99.0/24"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.vpc_cidr_block))
    error_message = "Variable var: vpc_cidr_block value must be a valid network CIDR, x.x.x.x/y."
  }
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
  validation {
    condition = (
      var.app_subnet_count <= 4
    )
    error_message = "App subnet count must be less than or equal to 4."
  }
}

variable "rds_subnet_count" {
  type        = number
  description = "value of the rds subnet count"
  default     = 2
  validation {
    condition = (
      var.rds_subnet_count <= 4
    )
    error_message = "Rds subnet count must be less than or equal to 4."
  }
}
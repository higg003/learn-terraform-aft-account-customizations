data "aws_region" "this" {}

#########################################
# VPC 
#########################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

#########################################
# VPC Subnets
#########################################

resource "aws_subnet" "app_subnet" {
  count = var.app_subnet_count

  vpc_id            = aws_vpc.this.id
  availability_zone = var.az_list[count.index]
  cidr_block        = var.app_subnet_cidr_block[count.index]

  tags = {
    Name = "${var.vpc_name}-APP-${count.index}"
  }
}

resource "aws_subnet" "rds_subnet" {
  count = var.rds_subnet_count

  vpc_id            = aws_vpc.this.id
  availability_zone = var.az_list[count.index]
  cidr_block        = var.rds_subnet_cidr_block[count.index]

  tags = {
    Name = "${var.vpc_name}-RDS-${count.index}"
  }
}

#########################################
# VPC Route Tables
#########################################

resource "aws_route_table" "app_route_table" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-RT"
  }

}

resource "aws_route_table" "rds_route_table" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-RT"
  }

}

resource "aws_vpc_endpoint_route_table_association" "app" {
  route_table_id  = aws_route_table.app_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "rds" {
  route_table_id  = aws_route_table.rds_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}


resource "aws_route_table_association" "app" {
  count          = var.app_subnet_count
  subnet_id      = aws_subnet.app_subnet[count.index].id
  route_table_id = aws_route_table.app_route_table.id
}

resource "aws_route_table_association" "rds" {
  count          = var.rds_subnet_count
  subnet_id      = aws_subnet.rds_subnet[count.index].id
  route_table_id = aws_route_table.rds_route_table.id
}


#########################################
# VPC Gateway Endpoints
#########################################

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${data.aws_region.this.name}.s3"
  route_table_ids   = [aws_route_table.app_route_table.id, aws_route_table.rds_route_table.id]

  tags = {
    Name = "${var.vpc_name}-S3"
  }
}
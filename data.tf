locals {
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
data "aws_subnet" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  for_each   = toset(local.public_subnets)
  cidr_block = each.key

}

data "aws_subnet" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  for_each   = toset(local.private_subnets)
  cidr_block = each.key
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  vpc_name = "observability-vpc-${random_string.suffix.result}"
}
module "cluster_vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "5.15.0"
  name                   = local.vpc_name
  cidr                   = var.vpc_cidr
  azs                    = data.aws_availability_zones.available.names
  private_subnets        = var.private_subnet_cidr
  public_subnets         = var.public_subnet_cidr
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags = {
    Environment = "observability"
  }
}
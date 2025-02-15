provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block      = var.vpc_cidr_block
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  create_nat_gateway = var.create_nat_gateway
  tags            = var.tags
}

module "iam" {
  source = "./modules/iam"

  cluster_role_name = var.cluster_role_name
  worker_role_name  = var.worker_role_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  worker_role_arn  = module.iam.worker_role_arn
  desired_size     = var.desired_size
  max_size         = var.max_size
  min_size         = var.min_size
  instance_types   = var.instance_types
}


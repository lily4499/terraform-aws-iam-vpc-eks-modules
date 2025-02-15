# How End Users Will Consume This Module  

Now, once modules are published, other teams can easily consume them. They can reference them directly from GitHub or, even better, from the Terraform Registry.

In your consuming project (for example, in a file like `main.tf`), you would reference the modules like this:

---

## Via GitHub (Direct URL):  

```hcl
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/lily4499/terraform-aws-modules.git//modules/vpc?ref=v1.0.0"
  region  = "us-east-1"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "main_vpc"
  public_subnets = [
    { cidr = "10.0.1.0/24", az = "us-east-1a", name = "Public Subnet 1" },
    { cidr = "10.0.2.0/24", az = "us-east-1b", name = "Public Subnet 2" }
  ]
  private_subnets = [
    { cidr = "10.0.3.0/24", az = "us-east-1a", name = "Private Subnet 1" },
    { cidr = "10.0.4.0/24", az = "us-east-1b", name = "Private Subnet 2" }
  ]
  create_nat_gateway = true
  tags = { Name = "main_vpc" }
}

module "iam" {
  source = "git::https://github.com/lily4499/terraform-aws-modules.git//modules/iam?ref=v1.0.0"
  region  = "us-east-1"
  cluster_role_name = "eks_cluster_role"
  worker_role_name  = "eks_worker_node_role"
}

module "eks" {
  source = "git::https://github.com/liliy4499/terraform-aws-modules.git//modules/eks?ref=v1.0.0"
  region  = "us-east-1"
  cluster_name     = "eks_cluster"
  cluster_version  = "1.26"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  worker_role_arn  = module.iam.worker_role_arn
  desired_size     = 1
  max_size         = 2
  min_size         = 1
  //instance_types   = ["t3.small", "t3.medium", "t3.large"]
  instance_types   = ["t3.small"]
}



## Via Terraform Registry (If Published Separately):  


provider "aws" {
  region = var.region
}

module "iam-vpc-eks-modules" {
  source  = "lily4499/iam-vpc-eks-modules/aws"
  version = "1.0.0"
  region  = "us-east-1"  # Overrides the default if the module uses it.

  # These values can be omitted if you are happy with the defaults
  vpc_cidr_block  = "10.0.0.0/16"
  vpc_name        = "main_vpc"
  public_subnets  = [
    { cidr = "10.0.1.0/24", az = "us-east-1a", name = "Public Subnet 1" },
    { cidr = "10.0.2.0/24", az = "us-east-1b", name = "Public Subnet 2" }
  ]
  private_subnets = [
    { cidr = "10.0.3.0/24", az = "us-east-1a", name = "Private Subnet 1" },
    { cidr = "10.0.4.0/24", az = "us-east-1b", name = "Private Subnet 2" }
  ]
  create_nat_gateway = true
  tags               = { Name = "main_vpc" }

  cluster_role_name  = "eks_cluster_role"
  worker_role_name   = "eks_worker_node_role"

  cluster_name       = "eks_cluster"
  cluster_version    = "1.26"
  desired_size       = 1
  max_size           = 2
  min_size           = 1
  //instance_types   = ["t3.small", "t3.medium", "t3.large"]
  instance_types   = ["t3.small"]
}




# Then They Simply Run:  


terraform init
terraform plan
terraform apply

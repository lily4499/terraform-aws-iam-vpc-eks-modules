# How End Users Will Consume This Module  

Now, once modules are published, other teams can easily consume them. They can reference them directly from GitHub or, even better, from the Terraform Registry.

In your consuming project (for example, in a file like `main.tf`), you would reference the modules like this:

---

## Via GitHub (Direct URL):  

```hcl
module "vpc" {
  source = "git::https://github.com/lily4499/terraform-aws-modules.git//modules/vpc?ref=v1.0.0"
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
  cluster_role_name = "eks_cluster_role"
  worker_role_name  = "eks_worker_node_role"
}

module "eks" {
  source = "git::https://github.com/lily4499/terraform-aws-modules.git//modules/eks?ref=v1.0.0"
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



module "vpc" {
  source  = "YOUR_USERNAME/vpc/aws"
  version = "1.0.0"

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
  source  = "YOUR_USERNAME/iam/aws"
  version = "1.0.0"

  cluster_role_name = "eks_cluster_role"
  worker_role_name  = "eks_worker_node_role"
}

module "eks" {
  source  = "YOUR_USERNAME/eks/aws"
  version = "1.0.0"

  cluster_name     = "eks_cluster"
  cluster_version  = "1.26"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  worker_role_arn  = module.iam.worker_role_arn
  desired_size     = 3
  max_size         = 5
  min_size         = 1
  instance_types   = ["t3.small", "t3.medium", "t3.large"]
}



# Then They Simply Run:  


terraform init
terraform plan
terraform apply

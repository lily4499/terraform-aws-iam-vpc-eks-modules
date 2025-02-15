variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "main_vpc"
}

variable "public_subnets" {
  description = "A list of public subnet configurations"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
  default = [
    { cidr = "10.0.1.0/24", az = "us-east-1a", name = "Public Subnet 1" },
    { cidr = "10.0.2.0/24", az = "us-east-1b", name = "Public Subnet 2" }
  ]
}

variable "private_subnets" {
  description = "A list of private subnet configurations"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
  default = [
    { cidr = "10.0.3.0/24", az = "us-east-1a", name = "Private Subnet 1" },
    { cidr = "10.0.4.0/24", az = "us-east-1b", name = "Private Subnet 2" }
  ]
}

variable "create_nat_gateway" {
  description = "Flag to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {
    Name = "main_vpc"
  }
}

variable "cluster_role_name" {
  description = "The name of the EKS cluster IAM role"
  type        = string
  default     = "eks_cluster_role"
}

variable "worker_role_name" {
  description = "The name of the EKS worker node IAM role"
  type        = string
  default     = "eks_worker_node_role"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks_cluster"
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.26"
}

variable "desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "A list of instance types for the worker nodes"
  type        = list(string)
  default     = ["t3.small"]
//  default     = ["t3.small", "t3.medium", "t3.large"]
}

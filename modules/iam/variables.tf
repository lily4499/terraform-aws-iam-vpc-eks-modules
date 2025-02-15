variable "cluster_role_name" {
  description = "The name of the EKS cluster IAM role"
  type        = string
}

variable "worker_role_name" {
  description = "The name of the EKS worker node IAM role"
  type        = string
}

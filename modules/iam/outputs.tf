output "cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "worker_role_arn" {
  description = "The ARN of the EKS worker node IAM role"
  value       = aws_iam_role.eks_worker_node_role.arn
}

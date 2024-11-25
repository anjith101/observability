# outputs.tf
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster"
  value       = module.eks.cluster_iam_role_name
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.cluster_vpc.vpc_id
}
output "node_group_iam_role_name" {
  description = "IAM role name associated with EKS cluster node group"
  value       = module.eks_managed_node_groups.iam_role_name
}
output "cluster_name" {
  description = "Name of the cluster"
  value       = module.eks.cluster_name
}

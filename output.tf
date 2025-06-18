output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.eks_vpc.id
}

output "subnet_ids" {
  description = "IDs of the subnets used in the EKS cluster"
  value       = aws_subnet.eks_subnet[*].id
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.exam_eks.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.exam_eks.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.exam_eks.certificate_authority[0].data
}

output "eks_node_group_role_arn" {
  description = "IAM role ARN used by EKS node group"
  value       = aws_iam_role.eks_node_group_role.arn
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN used by the EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "security_group_cluster_id" {
  description = "Security group ID for EKS cluster"
  value       = aws_security_group.eks_cluster_sg.id
}

output "security_group_node_id" {
  description = "Security group ID for EKS worker nodes"
  value       = aws_security_group.eks_node_sg.id
}

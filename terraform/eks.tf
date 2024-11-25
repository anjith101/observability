
locals {
  cluster_name    = "observability-cluster-${random_string.suffix.result}"
  node_group_name = "observability-node-${random_string.suffix.result}"
}
resource "random_string" "suffix" {
  special = false
  length  = 1
}
module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "20.29.0"
  cluster_name                             = local.cluster_name
  cluster_version                          = "1.27"
  vpc_id                                   = module.cluster_vpc.vpc_id
  subnet_ids                               = module.cluster_vpc.private_subnets
  cluster_endpoint_private_access          = true
  cluster_endpoint_public_access           = true
  create_cloudwatch_log_group              = false
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  tags = {
    Environment = "observability"
  }
}
module "eks_managed_node_groups" {
  source               = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  cluster_name         = local.cluster_name
  name                 = local.node_group_name
  cluster_version      = module.eks.cluster_version
  subnet_ids           = module.cluster_vpc.private_subnets
  min_size             = 2
  max_size             = 3
  desired_size         = 2
  instance_types       = var.instance_types
  capacity_type        = "ON_DEMAND"
  cluster_service_cidr = module.eks.cluster_service_cidr
  disk_size            = 20
  iam_role_additional_policies = {
    AmazonEKSVPCCNIPolicy                = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    AmazonEC2ContainerRegistryFullAccess = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
    AWSAppMeshFullAccess                 = "arn:aws:iam::aws:policy/AWSAppMeshFullAccess"
    ElasticLoadBalancingFullAccess       = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    AmazonRoute53FullAccess              = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  }

  tags = {
    Name = "observability-ng-private"
  }
}
resource "null_resource" "update_kube_config" {
  depends_on = [module.eks, module.eks_managed_node_groups]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
  }
}
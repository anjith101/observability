# Observability Infrastructure Deployment

## Overview

This Terraform project creates an AWS EKS (Elastic Kubernetes Service) cluster with a supporting VPC for observability purposes. The infrastructure is designed to provide a robust and scalable Kubernetes environment.

## Resources Created

### 1. VPC (Virtual Private Cloud)
- Creates a VPC with configurable CIDR block
- Provisions both public and private subnets across available Availability Zones
- Configures NAT Gateway for private subnet internet access
- Adds Kubernetes-specific subnet tags for EKS compatibility

### 2. EKS Cluster
- Creates an Amazon EKS cluster (Kubernetes version 1.27)
- Enables both private and public endpoint access
- Configures IRSA (IAM Roles for Service Accounts)
- Provides cluster creator admin permissions

### 3. EKS Managed Node Group
- Deploys managed node group in private subnets
- Configures node group with:
 - Minimum 2 nodes
 - Maximum 3 nodes
 - Desired 2 nodes
- ### Assigns additional IAM policies including:
 - EKS CNI Policy
 - ECR Full Access
 - App Mesh Full Access
 - Elastic Load Balancing Full Access
 - Route 53 Full Access

### 4. Kubernetes Namespaces
- Creates multiple Kubernetes namespaces as defined in variables
- Adds metadata and labels to namespaces

## Prerequisites

- AWS CLI installed and configured
- Terraform (latest version recommended)
- AWS account with necessary permissions
- kubectl installed

## Deployment Steps

### Initialize Terraform, validate configuration, and apply:
```bash
terraform init
terraform plan
terraform apply
```
## Post-Deployment
After successful deployment, you can interact with your cluster using:
```bash
kubectl get nodes
kubectl get namespaces
```
## Notes
- The infrastructure uses a random suffix to ensure unique resource names
- NAT Gateway is configured with a single gateway for cost optimization
- Node instances are ON_DEMAND type with 20GB disk size
## Clean Up
### Do not forget to destroy the infrastructure after use !!
```bash
terraform destroy
```
## Important Considerations
- Ensure you have the necessary AWS credentials and permissions
- Review and adjust variables according to your specific requirements
- Be aware of potential costs associated with AWS resources
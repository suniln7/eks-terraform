# AWS EKS Infrastructure with Terraform

This repository contains Terraform configurations to deploy a fully functional AWS Elastic Kubernetes Service (EKS) infrastructure. It provisions the necessary AWS resources, including VPC, subnets, IAM roles, and integrates AWS EKS add-ons like CoreDNS and the EBS CSI driver.

## Features
- Managed EKS cluster with worker node groups
- Public and private subnets optimized for EKS integration
- IAM roles for EKS components, including support for EBS CSI drivers
- SSH access setup for EKS nodes via key pairs
- Automatic tagging for resources based on environment (e.g., `dev`, `prod`)

## Prerequisites
- AWS account with appropriate IAM permissions
- Terraform >= 1.0.0
- AWS CLI configured with credentials

## Continuous Integration and Deployment (CI/CD)
This project leverages GitLab CI/CD for automated infrastructure provisioning using Terraform. The CI/CD pipeline ensures that changes are validated, planned, and applied in a controlled and automated manner.

### GitLab CI Pipeline Stages:
1. **Check**: 
   - Runs `terraform fmt` to format the code and `terraform validate` to check for syntax errors.
   
2. **Plan**: 
   - Generates and reports a Terraform execution plan, allowing you to review infrastructure changes.
   
3. **Apply**: 
   - Applies the changes based on the reviewed plan (manual trigger).
   
4. **Destroy**: 
   - Manually trigger the destruction of infrastructure in a given environment.

### How to Use CI/CD:
- Ensure your changes are committed and pushed to the appropriate GitLab branch (e.g., `dev`).
- GitLab CI/CD will automatically run the `plan` stage for the `dev` environment.
- To apply changes, manually trigger the `apply` job in GitLab's UI.
- To destroy resources, manually trigger the `destroy` job.

## Usage
1. Initialize and apply the configuration for your environment:
   ```bash
   terraform init
   terraform apply -var-file=".vars/variables.dev.tfvars"
   ```

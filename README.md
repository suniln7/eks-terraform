# AWS EKS Terraform Automation

This project automates the deployment of an AWS EKS (Elastic Kubernetes Service) cluster and related infrastructure using Terraform. It provisions VPC, subnets, IAM roles, and integrates AWS EKS add-ons such as CoreDNS, kube-proxy, VPC CNI, and EBS CSI driver.

## Key Features
- **EKS Cluster**: Deploys an AWS EKS cluster with managed node groups.
- **IAM Roles**: Creates roles for the EKS components, including EBS CSI driver support.
- **VPC & Subnets**: Manages public and private subnets within an existing VPC.
- **SSH Access**: Sets up SSH access for the EKS nodes via key pairs.
- **AWS Add-ons**: Includes CoreDNS, kube-proxy, VPC CNI, and EBS CSI drivers.

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) v1.0.0+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials configured in your environment
## Usage

```bash
terraform init
terraform apply -var-file="./vars/variables.dev.tfvars"
```


variable "aws_region" {
  type        = string
  description = "AWS region used to assing availability zones to vpc"
}

# EKS cluster
variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "AWS EKS cluster version"
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID in which EKS should be created"
  type        = string
}

variable "eks_pub_ssh_key" {
  description = "SSH public key for eks node group"
  type        = string
}

variable "private_subnets" {
  type        = list(string)
  description = "list of private subnets cidr range"
}

variable "public_subnets" {
  type        = list(string)
  description = "list of public subnets cidr range"
}



variable "image_id" {
  description = "Image ID which is used to create managed node groups"
  type        = string
}

variable "launch_template_version" {
  description = "launch template version nodegroups to use"
  type        = number
}

variable "aws-ebs-csi-driver-version" {
  description = "aws-ebs-csi-driver-version version "
  type        = string
}

variable "vpc-cni-version" {
  description = "vpc-cni-version version "
  type        = string
}

variable "kube-proxy-version" {
  description = "kube-proxy-version  version "
  type        = string
}


variable "coredns-version" {
  description = "coredns-version version "
  type        = string
}

variable "storage_size" {
  description = "storage size for EBS volumes "
  type        = number
  default     = 150
}

variable "Environment" {
  description = "Each environment have each tags"
  type        = string
}


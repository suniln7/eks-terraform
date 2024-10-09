locals {
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  infra_env = terraform.workspace

  tags = {
    Terraform   = "true"
    Environment = var.Environment
    Name        = local.cluster_name


  }
}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name                    = local.cluster_name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_addons = {
    coredns = {
      most_recent   = false
      addon_version = var.coredns-version #"v1.9.3-eksbuild.5"
    }
    kube-proxy = {
      most_recent   = false
      addon_version = var.kube-proxy-version #"v1.26.6-eksbuild.1"
    }
    vpc-cni = {
      most_recent   = false
      addon_version = var.vpc-cni-version #"v1.13.2-eksbuild.1"
    }
    aws-ebs-csi-driver = {
      service_account_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.cluster_name}-ebs-csi-controller"
      most_recent              = false
      addon_version            = var.aws-ebs-csi-driver-version #"v1.20.0-eksbuild.1"
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = toset([for subnet in data.aws_subnet.private : subnet.id])
  control_plane_subnet_ids = toset([for subnet in data.aws_subnet.public : subnet.id])

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    ami_id     = var.image_id
    subnet_ids = toset([for subnet in data.aws_subnet.private : subnet.id])
    # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
    # so we need to disable it to use the default template provided by the AWS EKS managed node group service
    use_custom_launch_template = true
    create_launch_template     = false

  }

  eks_managed_node_groups = {
  for group_name, group in var.eks_managed_node_groups : 
  group_name => {
    name               = group.name
    instance_types     = group.instance_types
    desired_size       = group.desired_size
    min_size           = group.min_size
    max_size           = group.max_size
    launch_template_id = aws_launch_template.custom_eks_node_group_launch_template.id
    launch_template_version = var.launch_template_version
    force_update_version = group.force_update_version
    use_name_prefix = true
    enable_bootstrap_user_data = true
    labels = group.labels
    taints = group.taints
  }
 }


  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  tags = local.tags

}
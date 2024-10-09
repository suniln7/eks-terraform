aws_region      = "us-east-1"
cluster_name    = "dev-eks"
cluster_version = "1.29"
# Create new Public KEY

eks_pub_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEKb4wyjKfUq+XUK6SSXyYbF0vrwdmTEjsfYy6Yf2Y8eeV231wZieOtqjnx3RjG4mRdr1GSnMIs46Ea6mMK7dmgZoqhoTHveepLP/QPvd/imstuId2rPm7/TAjUqLUOzufkSpKLEJ0Sk2t/5WytufC2yh9gbyDHSfp89M9cpcJjVbkFYdvF/dsxVP+h+TiuM1oQ12zNLyI1DpxctrWEmtWy7CWh+p0FgpdyAWPWGaw0rQyLt4Od2M7ugEacL20xddZVTCxYaPpGcfB8IGS5o7IXUFEJM/ykV8xweLB2l6hcGWBO0fviRPEpmt1UW9gqaXO+7mAEhSaBtv93yCHe5X5IW044zU2xLrxCS+rwBaCVhf8u5+e/pC7A+dzjeF4mdA0XFd2oW+E1b+IIO+T3RFDIa80r9y+bLPi/r+SXg06zxQXgKCmtW2FMyU4fgQ1oL7aWIQJn7o4LHR3h+nnndKxE4tAu8EQNrFhSSgxIgSCENELMJglKAOb4oBDsF7X6lU= root@SPFHYLO-0294"
vpc_id          = "vpc-0703c0dcb945a26b9"

private_subnets = ["10.40.2.0/24", "10.40.1.0/24", "10.40.3.0/24", "10.40.13.0/24"]
public_subnets  = ["10.40.107.0/24", "10.40.108.0/24", "10.40.109.0/24"]

/* ami_id is specefic to Region https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.html */
# amazon-eks-node-1.29-v20240307
image_id = "ami-0b047bdfc83a5c3f4"

#Tags
Environment = "Dev"

# add-on's supported-1.29-EKS-cluster's
aws-ebs-csi-driver-version = "v1.28.0-eksbuild.1"
coredns-version            = "v1.11.1-eksbuild.9"
vpc-cni-version            = "v1.18.1-eksbuild.3"
kube-proxy-version         = "v1.29.1-eksbuild.2"

launch_template_version = 1
# storage_size = "150"

eks_managed_node_groups = {
  r5-large = {
    name                 = "t3-large"
    min_size             = 1
    max_size             = 1
    desired_size         = 1
    instance_types       = ["t3.large"]
    force_update_version = true
    labels               = {}
    taints               = {}
  }
}
resource "aws_launch_template" "custom_eks_node_group_launch_template" {
  name = "${var.cluster_name}_custom_node_launch_template"

  vpc_security_group_ids = [aws_security_group.remote_access.id, module.eks.cluster_primary_security_group_id]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.storage_size
      volume_type = "gp3"
    }
  }

  image_id = var.image_id
  key_name = aws_key_pair.this.key_name

  user_data = base64encode(<<-EOF
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
    --==MYBOUNDARY==
    Content-Type: text/x-shellscript; charset="us-ascii"
    #!/bin/bash
    set -ex
    CLUSTER_NAME=$(aws eks describe-cluster --name "${var.cluster_name}" --query "cluster.name" --output text)
    CLUSTER_ENDPOINT=$(aws eks describe-cluster --name "${var.cluster_name}" --query "cluster.endpoint" --output text)
    CERTIFICATE_AUTHORITY=$(aws eks describe-cluster --name "${var.cluster_name}" --query "cluster.certificateAuthority.data" --output text)
    K8S_CLUSTER_DNS_IP=$(aws eks describe-cluster --name "${var.cluster_name}" --query "cluster.kubernetesNetworkConfig.serviceIpv4Cidr" --output text --region "${var.aws_region}" | awk -F"/" '{print $1}' | sed 's/0$/10/')
    /etc/eks/bootstrap.sh $CLUSTER_NAME 
    --b64-cluster-ca $CERTIFICATE_AUTHORITY 
    --apiserver-endpoint $CLUSTER_ENDPOINT 
    --dns-cluster-ip $K8S_CLUSTER_DNS_IP 
    --use-max-pods false
    --==MYBOUNDARY==--\
      EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = local.tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.tags
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = local.tags
  }
}

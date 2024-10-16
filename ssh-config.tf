resource "aws_key_pair" "this" {
  key_name_prefix = local.cluster_name
  public_key      = var.eks_pub_ssh_key

  tags = local.tags
}

resource "aws_security_group" "remote_access" {
  name_prefix = "${local.cluster_name}-remote-access"
  description = "Allow remote SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = local.tags
}

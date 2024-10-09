terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }

  #   backend "s3" {
  #     key     = "eks/terraform.tfstate"
  #     region  = "us-east-1"
  #     bucket  = "bucketname"
  #     profile = "default"
  #     # region = "ap-south-1"

  #     # profile = "dev"
  #   }

}
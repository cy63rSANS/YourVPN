terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.64.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Environment = "VPNoD"
    }
  }
}
# Configure Terraform and required providers
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    key    = "terraform/state/terraformstatefile"
    bucket = "terrraformstatebucket6655"
    
    # Enable state locking
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

# Data sources for availability zones
data "aws_availability_zones" "master_azs" {
  provider = aws.region-master
  state    = "available"
}

data "aws_availability_zones" "worker_azs" {
  provider = aws.region-worker
  state    = "available"
}

# Local values for common tags
locals {
  common_tags = {
    Environment = "jenkins"
    Project     = "multi-region-vpc"
    ManagedBy   = "terraform"
  }
}
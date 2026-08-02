provider "aws" {
region = var.aws_region

default_tags {
tags = {
Project     = "terraform-production-platform"
Environment = "bootstrap"
ManagedBy   = "Terraform"
Owner       = "Arul Kumar"
Repository  = "Terraform"
CostCenter  = "Cloud"
}
}
}

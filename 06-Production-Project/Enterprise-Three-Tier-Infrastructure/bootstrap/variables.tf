variable "aws_region" {
description = "AWS Region where bootstrap resources will be created."
type        = string
default     = "ap-south-1"
}

variable "project_name" {
description = "Project name used for naming AWS resources."
type        = string
default     = "terraform-production-platform"
}

variable "environment" {
description = "Deployment environment."
type        = string
default     = "bootstrap"
}

variable "terraform_state_bucket_name" {
description = "Globally unique S3 bucket name for Terraform remote state."
type        = string
}

variable "terraform_lock_table_name" {
description = "DynamoDB table name used for Terraform state locking."
type        = string
default     = "terraform-state-lock"
}

variable "enable_bucket_versioning" {
description = "Enable versioning on the Terraform state bucket."
type        = bool
default     = true
}

variable "force_destroy_bucket" {
description = "Allow bucket deletion even if it contains objects."
type        = bool
default     = false
}

variable "tags" {
description = "Additional resource tags."
type        = map(string)

default = {
ManagedBy = "Terraform"
Owner     = "Arul Kumar"
Repository = "Terraform"
}
}

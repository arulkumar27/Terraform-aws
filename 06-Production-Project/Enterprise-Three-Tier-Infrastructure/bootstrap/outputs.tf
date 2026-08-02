output "terraform_state_bucket_name" {
description = "Name of the S3 bucket used to store Terraform state."
value       = aws_s3_bucket.terraform_state.id
}

output "terraform_state_bucket_arn" {
description = "ARN of the S3 bucket used to store Terraform state."
value       = aws_s3_bucket.terraform_state.arn
}

output "terraform_state_bucket_region" {
description = "AWS Region of the Terraform state bucket."
value       = aws_s3_bucket.terraform_state.region
}

output "terraform_lock_table_name" {
description = "Name of the DynamoDB table used for Terraform state locking."
value       = aws_dynamodb_table.terraform_lock.name
}

output "terraform_lock_table_arn" {
description = "ARN of the DynamoDB table used for Terraform state locking."
value       = aws_dynamodb_table.terraform_lock.arn
}

output "backend_configuration_example" {
description = "Example backend configuration for environment deployments."

value = <<-EOT
bucket         = "${aws_s3_bucket.terraform_state.id}"
key            = "ENVIRONMENT/terraform.tfstate"
region         = "${var.aws_region}"
dynamodb_table = "${aws_dynamodb_table.terraform_lock.name}"
encrypt        = true
use_lockfile   = true
EOT
}

locals {
common_tags = merge(
{
Project     = var.project_name
Environment = var.environment
ManagedBy   = "Terraform"
Owner       = "Arul Kumar"
},
var.tags
)
}

resource "aws_s3_bucket" "terraform_state" {
bucket        = var.terraform_state_bucket_name
force_destroy = var.force_destroy_bucket

tags = merge(
local.common_tags,
{
Name = "${var.project_name}-state"
}
)
}

resource "aws_s3_bucket_versioning" "terraform_state" {
bucket = aws_s3_bucket.terraform_state.id

versioning_configuration {
status = var.enable_bucket_versioning ? "Enabled" : "Suspended"
}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
bucket = aws_s3_bucket.terraform_state.id

rule {
apply_server_side_encryption_by_default {
sse_algorithm = "AES256"
}

```
bucket_key_enabled = true
```

}
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
bucket = aws_s3_bucket.terraform_state.id

block_public_acls       = true
ignore_public_acls      = true
block_public_policy     = true
restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "terraform_state" {
bucket = aws_s3_bucket.terraform_state.id

rule {
object_ownership = "BucketOwnerEnforced"
}
}

resource "aws_dynamodb_table" "terraform_lock" {
name         = var.terraform_lock_table_name
billing_mode = "PAY_PER_REQUEST"
hash_key     = "LockID"

attribute {
name = "LockID"
type = "S"
}

tags = merge(
local.common_tags,
{
Name = "${var.project_name}-lock-table"
}
)
}

# Remote Backend

A Remote Backend stores the Terraform State file in a remote location instead of your local machine.

For AWS, the most common setup is:

- Amazon S3 → Stores the state file
- DynamoDB → Prevents multiple users from modifying the state simultaneously

## Example

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

## Advantages

- Shared state
- Secure storage
- Team collaboration
- State locking

---

## Interview Question

**Q. Why use a Remote Backend?**

**Answer:**
A Remote Backend securely stores the Terraform State file and allows teams to collaborate safely.
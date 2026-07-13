# State Management

Terraform stores information about the infrastructure it manages in a **State File**.

The state file keeps track of created resources and their current status.

## Default State File

```text
terraform.tfstate
```

## Why State is Important?

- Tracks infrastructure
- Maps resources to configuration
- Detects changes
- Helps update existing resources

## Useful Commands

```bash
terraform show
```

```bash
terraform state list
```

## Best Practices

- Don't edit the state file manually.
- Don't upload state files to GitHub.
- Use a remote backend for team projects.

---

## Interview Question

**Q. What is Terraform State?**

**Answer:**
Terraform State is a file that stores information about the infrastructure managed by Terraform.
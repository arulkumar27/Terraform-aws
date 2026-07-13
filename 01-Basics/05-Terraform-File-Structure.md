# Terraform File Structure

A basic Terraform project contains the following files:

```
terraform-project/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── .gitignore
```

---

## File Description

### main.tf

Contains the main infrastructure resources.

### provider.tf

Defines the cloud provider (AWS, Azure, GCP).

### variables.tf

Stores input variables.

### outputs.tf

Displays output values after deployment.

### terraform.tfvars

Stores variable values.

### .gitignore

Prevents sensitive files from being pushed to GitHub.

---

## Best Practice

- Keep code modular.
- Use variables instead of hardcoding values.
- Store sensitive values securely.
- Push code to GitHub without state files.
# Providers

A Provider is a plugin that allows Terraform to interact with a platform or cloud service.

Examples:
- AWS
- Azure
- Google Cloud
- Kubernetes
- Docker

## AWS Provider Example

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

## Why Providers?

- Connect Terraform to cloud platforms
- Manage cloud resources
- Downloaded during terraform init

## Interview Question

Q. What is a Provider in Terraform?

A. A Provider is a plugin that enables Terraform to interact with cloud platforms and services.
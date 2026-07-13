# Modules

A Module is a reusable collection of Terraform configuration files.

Instead of writing the same code multiple times, create a module and reuse it.

## Example Structure

```text
modules/
└── ec2/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

## Using a Module

```hcl
module "ec2" {
  source = "./modules/ec2"
}
```

## Advantages

- Reusable code
- Easy maintenance
- Better organization
- Less duplication

---

## Interview Question

**Q. What is a Module?**

**Answer:**
A Module is a reusable Terraform configuration that helps organize and simplify infrastructure code.
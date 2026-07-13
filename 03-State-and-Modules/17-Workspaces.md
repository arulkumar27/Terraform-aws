# Workspaces

Terraform Workspaces allow you to manage multiple environments using the same configuration.

Examples:

- dev
- test
- stage
- prod

## Commands

Create a workspace

```bash
terraform workspace new dev
```

List workspaces

```bash
terraform workspace list
```

Switch workspace

```bash
terraform workspace select prod
```

Show current workspace

```bash
terraform workspace show
```

## Benefits

- Separate environments
- Reuse the same code
- Easy environment management

---

## Interview Question

**Q. What is a Workspace?**

**Answer:**
A Workspace allows multiple state files for different environments using the same Terraform configuration.
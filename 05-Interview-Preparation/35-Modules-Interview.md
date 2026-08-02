# Terraform Modules Interview Questions & Answers

## Overview

Terraform Modules are reusable collections of Terraform configuration files used to organize infrastructure, reduce code duplication, and improve maintainability. Modules are considered a best practice for building scalable and production-ready Terraform projects.

---

# Q1. What is a Terraform Module?

**Answer:**

A Terraform Module is a reusable container of Terraform resources that can be called multiple times from different configurations.

It helps organize infrastructure into reusable and maintainable components.

---

# Q2. Why do we use Modules?

**Answer:**

Modules provide several benefits:

- Code Reusability
- Better Organization
- Reduced Duplication
- Easier Maintenance
- Standardization
- Scalability
- Team Collaboration

---

# Q3. What are the types of Modules?

**Answer:**

Terraform supports two types of modules:

1. Root Module
2. Child Module

---

# Q4. What is a Root Module?

**Answer:**

The Root Module is the main Terraform configuration in the current working directory.

It is the entry point for Terraform commands such as:

```bash
terraform init
terraform plan
terraform apply
```

---

# Q5. What is a Child Module?

**Answer:**

A Child Module is any module that is called from another module using the `module` block.

Example:

```hcl
module "vpc" {
  source = "./modules/vpc"
}
```

---

# Q6. What is the typical structure of a Module?

**Answer:**

```
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── versions.tf
    └── README.md
```

---

# Q7. How do you call a Module?

**Answer:**

Using the `module` block.

Example:

```hcl
module "ec2" {

  source = "./modules/ec2"

  instance_type = "t3.micro"

}
```

---

# Q8. What is the `source` argument in a Module?

**Answer:**

The `source` argument specifies where Terraform should load the module from.

Examples:

Local

```hcl
source = "./modules/vpc"
```

GitHub

```hcl
source = "github.com/company/vpc-module"
```

Terraform Registry

```hcl
source = "terraform-aws-modules/vpc/aws"
```

---

# Q9. How do Modules receive input values?

**Answer:**

Modules receive values through input variables.

Example:

```hcl
variable "instance_type" {
  type = string
}
```

Module Call:

```hcl
instance_type = "t3.micro"
```

---

# Q10. How do Modules return values?

**Answer:**

Modules expose values using outputs.

Example:

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

Root Module:

```hcl
module.vpc.vpc_id
```

---

# Q11. Can one Module call another Module?

**Answer:**

Yes.

Terraform supports nested modules, where one child module can call another child module.

---

# Q12. What are Registry Modules?

**Answer:**

Registry Modules are pre-built modules published on the Terraform Registry by HashiCorp and the community.

Example:

- VPC Module
- EC2 Module
- IAM Module
- EKS Module

---

# Q13. Why are Modules important in production?

**Answer:**

Modules improve:

- Consistency
- Standardization
- Maintainability
- Reusability
- Team collaboration

Large organizations rarely place all resources in a single `main.tf` file.

---

# Q14. What is Module Versioning?

**Answer:**

Module Versioning ensures a specific version of a module is used.

Example:

```hcl
module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"

  version = "5.1.0"

}
```

This prevents unexpected behavior from module updates.

---

# Q15. What are Module Outputs used for?

**Answer:**

Outputs allow one module to expose information to another module.

Example:

```
VPC Module

↓

Outputs VPC ID

↓

EC2 Module uses VPC ID
```

---

# Q16. Can Modules be shared across projects?

**Answer:**

Yes.

Modules are designed to be reusable and can be stored in:

- GitHub
- Terraform Registry
- Private Module Registry
- Local directories

---

# Q17. Difference between Modules and Resources?

| Module | Resource |
|--------|----------|
| Collection of Resources | Single Infrastructure Object |
| Reusable | Individual Component |
| Improves Organization | Creates Infrastructure |

---

# Q18. How do you organize a production Terraform project?

**Answer:**

Example:

```
terraform-project/

├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
│
└── modules/
    ├── vpc/
    ├── ec2/
    ├── alb/
    ├── rds/
    ├── iam/
    └── security-group/
```

---

# Q19. What are Module Best Practices?

**Answer:**

- Keep modules focused on a single responsibility.
- Use variables instead of hardcoded values.
- Expose only necessary outputs.
- Include documentation.
- Pin module versions.
- Use meaningful names.
- Avoid circular dependencies.

---

# Q20. What happens if you change a Module?

**Answer:**

Terraform detects the changes during `terraform plan`.

Depending on the modification, it may:

- Update resources
- Replace resources
- Leave resources unchanged

Always review the execution plan before applying.

---

# Scenario-Based Questions

### Scenario 1

**Your project has 20 EC2 instances with identical configurations. How would you avoid code duplication?**

**Answer:**

Create a reusable EC2 module and call it multiple times with different input variables.

---

### Scenario 2

**Your company has separate Dev, Test, and Production environments. How can Modules help?**

**Answer:**

Use the same reusable modules for all environments while passing different variable values such as instance types, CIDR blocks, and tags.

---

### Scenario 3

**You need to update the Security Group configuration used by hundreds of servers. What is the best approach?**

**Answer:**

Update the Security Group module once. All projects using that module can then receive the updated configuration after reviewing and applying the changes.

---

# Quick Revision

| Topic | Key Point |
|--------|-----------|
| Module | Reusable Terraform Code |
| Root Module | Main Working Directory |
| Child Module | Called by Another Module |
| source | Module Location |
| variables.tf | Module Inputs |
| outputs.tf | Module Outputs |
| Registry | Shared Modules |
| Version | Module Version Control |

---

# Interview Tips

- Explain that **modules reduce code duplication** and **improve maintainability**.
- Mention that production Terraform projects are **modular**, not a single large `main.tf`.
- Differentiate clearly between **Root Module** and **Child Module**.
- Mention that modules are commonly stored in **GitHub** or the **Terraform Registry** and versioned for stability.

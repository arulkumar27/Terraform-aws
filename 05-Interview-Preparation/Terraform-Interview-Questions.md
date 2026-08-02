# Terraform Interview Questions & Answers

## Overview

This document contains frequently asked Terraform interview questions ranging from beginner to advanced levels. The questions are grouped by topic to help candidates prepare for real-world DevOps and Cloud Engineer interviews.

---

# Table of Contents

1. Terraform Fundamentals
2. Terraform Workflow
3. State Management
4. Variables & Outputs
5. Providers & Resources
6. Modules
7. Provisioners
8. Backend & Remote State
9. Lifecycle & Meta Arguments
10. Workspaces
11. Data Sources
12. Functions & Expressions
13. AWS Resources
14. Security
15. Best Practices
16. Scenario-Based Questions
17. Advanced Terraform
18. CI/CD Integration
19. Troubleshooting
20. Rapid Fire Questions

---

# 1. Terraform Fundamentals

### Q1. What is Terraform?

**Answer:**
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp that allows us to provision and manage infrastructure across multiple cloud providers using declarative configuration files.

---

### Q2. What is Infrastructure as Code (IaC)?

**Answer:**
Infrastructure as Code is the practice of managing infrastructure through code instead of manual configuration, enabling automation, consistency, version control, and repeatable deployments.

---

### Q3. Why Terraform instead of manually creating resources?

**Answer:**

- Automation
- Version Control
- Repeatability
- Reduced Human Errors
- Multi-Cloud Support
- Easy Rollback
- Faster Deployment

---

### Q4. Is Terraform declarative or imperative?

**Answer:**
Terraform is a **declarative** Infrastructure as Code tool. We define the desired state, and Terraform determines the execution plan to achieve that state.

---

### Q5. Which languages are supported by Terraform?

**Answer:**
Terraform uses **HCL (HashiCorp Configuration Language)**. It also supports JSON syntax, although HCL is the recommended format.

---

### Q6. Explain the Terraform workflow.

**Answer:**

```
Write Code
      ↓
terraform init
      ↓
terraform validate
      ↓
terraform plan
      ↓
terraform apply
      ↓
terraform destroy (if required)
```

---

### Q7. What happens during `terraform init`?

**Answer:**

- Downloads providers
- Initializes backend
- Downloads modules
- Creates `.terraform` directory
- Prepares the working directory

---

### Q8. Difference between `terraform plan` and `terraform apply`?

| terraform plan | terraform apply |
|----------------|-----------------|
| Shows changes | Executes changes |
| No infrastructure modification | Creates/updates infrastructure |
| Safe to run anytime | Makes actual changes |

---

### Q9. What is the Terraform state file?

**Answer:**
The state file (`terraform.tfstate`) stores metadata about managed infrastructure, allowing Terraform to track resources and determine the required changes.

---

### Q10. Why should we store the state file remotely?

**Answer:**

- Team Collaboration
- Versioning
- Locking
- Disaster Recovery
- Centralized Management

---

# 2. Providers & Resources

### Q11. What is a Provider?

**Answer:**
A provider is a plugin that enables Terraform to interact with external platforms such as AWS, Azure, Google Cloud, or Kubernetes.

---

### Q12. What is a Resource?

**Answer:**
A resource represents an infrastructure object managed by Terraform, such as an EC2 instance, S3 bucket, VPC, or IAM Role.

---

### Q13. Difference between Provider and Resource?

| Provider | Resource |
|----------|----------|
| Connects Terraform to a platform | Creates infrastructure |
| Example: AWS | Example: EC2 |
| Plugin | Infrastructure Object |

---

### Q14. Can Terraform use multiple providers?

**Answer:**
Yes. Terraform supports multiple providers in a single configuration, allowing deployments across AWS, Azure, GCP, Kubernetes, GitHub, and more.

---

### Q15. What is an alias provider?

**Answer:**
An alias provider allows multiple configurations of the same provider, such as deploying resources into different AWS regions.

Example:

```hcl
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}
```

---

# Continue...

- Variables & Outputs (15+ Questions)
- Modules (20+ Questions)
- State Management (25+ Questions)
- Backend (15+ Questions)
- Lifecycle (15+ Questions)
- Provisioners (15+ Questions)
- Data Sources (10+ Questions)
- Workspaces (10+ Questions)
- AWS + Terraform (30+ Questions)
- CI/CD Integration (15+ Questions)
- Troubleshooting (20+ Questions)
- Scenario-Based (30+ Questions)
- Rapid Fire (50+ Questions)

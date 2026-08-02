# Terraform Rapid Fire Interview Questions

## Overview

This document contains short, one-line Terraform interview questions and answers for quick revision before interviews.

---

## Terraform Basics

### Q1. What is Terraform?

Infrastructure as Code (IaC) tool developed by HashiCorp.

---

### Q2. Which language does Terraform use?

HCL (HashiCorp Configuration Language).

---

### Q3. Is Terraform declarative or imperative?

Declarative.

---

### Q4. Is Terraform agentless?

Yes.

---

### Q5. Who developed Terraform?

HashiCorp.

---

### Q6. What is Infrastructure as Code?

Managing infrastructure through code instead of manual configuration.

---

### Q7. What is a Provider?

A plugin that enables Terraform to communicate with cloud platforms.

---

### Q8. What is a Resource?

An infrastructure object managed by Terraform.

---

### Q9. What is a Module?

A reusable collection of Terraform resources.

---

### Q10. What is HCL?

HashiCorp Configuration Language.

---

## Terraform Commands

### Q11. Which command initializes Terraform?

```bash
terraform init
```

---

### Q12. Which command formats Terraform code?

```bash
terraform fmt
```

---

### Q13. Which command validates Terraform configuration?

```bash
terraform validate
```

---

### Q14. Which command previews changes?

```bash
terraform plan
```

---

### Q15. Which command creates infrastructure?

```bash
terraform apply
```

---

### Q16. Which command destroys infrastructure?

```bash
terraform destroy
```

---

### Q17. Which command displays the current state?

```bash
terraform show
```

---

### Q18. Which command lists resources in the state?

```bash
terraform state list
```

---

### Q19. Which command imports existing infrastructure?

```bash
terraform import
```

---

### Q20. Which command removes a stale lock?

```bash
terraform force-unlock
```

---

## State

### Q21. Default Terraform state file?

```
terraform.tfstate
```

---

### Q22. Why is the state file important?

It tracks infrastructure managed by Terraform.

---

### Q23. Recommended backend for AWS?

Amazon S3.

---

### Q24. Which service provides state locking?

Amazon DynamoDB.

---

### Q25. What is State Drift?

Manual infrastructure changes outside Terraform.

---

## Modules

### Q26. Root Module?

The current working directory.

---

### Q27. Child Module?

A module called by another module.

---

### Q28. Where are reusable modules stored?

Terraform Registry or Git repositories.

---

### Q29. Which block calls a module?

```hcl
module
```

---

### Q30. Module inputs?

Variables.

---

### Q31. Module outputs?

Outputs.

---

## Meta Arguments

### Q32. Which meta argument creates multiple resources?

```hcl
count
```

---

### Q33. Which meta argument creates resources from collections?

```hcl
for_each
```

---

### Q34. Which meta argument defines dependencies?

```hcl
depends_on
```

---

### Q35. Which meta argument customizes resource lifecycle?

```hcl
lifecycle
```

---

### Q36. Which lifecycle rule prevents accidental deletion?

```hcl
prevent_destroy
```

---

## Variables

### Q37. Variable definition file?

```
variables.tf
```

---

### Q38. Default variable values?

Defined using `default`.

---

### Q39. Variable values file?

```
terraform.tfvars
```

---

### Q40. Output definition file?

```
outputs.tf
```

---

## AWS Resources

### Q41. EC2 Resource?

```hcl
aws_instance
```

---

### Q42. VPC Resource?

```hcl
aws_vpc
```

---

### Q43. Subnet Resource?

```hcl
aws_subnet
```

---

### Q44. Security Group Resource?

```hcl
aws_security_group
```

---

### Q45. Internet Gateway Resource?

```hcl
aws_internet_gateway
```

---

### Q46. NAT Gateway Resource?

```hcl
aws_nat_gateway
```

---

### Q47. S3 Bucket Resource?

```hcl
aws_s3_bucket
```

---

### Q48. IAM Role Resource?

```hcl
aws_iam_role
```

---

### Q49. RDS Resource?

```hcl
aws_db_instance
```

---

### Q50. Load Balancer Resource?

```hcl
aws_lb
```

---

### Q51. Target Group Resource?

```hcl
aws_lb_target_group
```

---

### Q52. Auto Scaling Group Resource?

```hcl
aws_autoscaling_group
```

---

### Q53. CloudWatch Alarm Resource?

```hcl
aws_cloudwatch_metric_alarm
```

---

### Q54. Route 53 Record Resource?

```hcl
aws_route53_record
```

---

## Production Best Practices

### Q55. Preferred storage for state?

Remote Backend.

---

### Q56. Should state files be committed to Git?

No.

---

### Q57. Recommended EC2 authentication?

IAM Roles.

---

### Q58. Recommended database location?

Private Subnet.

---

### Q59. Recommended web server location?

Public Subnet behind an ALB.

---

### Q60. Recommended storage type for production EBS?

gp3.

---

### Q61. Recommended S3 security?

Enable Versioning, Encryption, and Block Public Access.

---

### Q62. Recommended Load Balancer?

Application Load Balancer (ALB).

---

### Q63. Recommended scaling method?

Auto Scaling Group with Target Tracking.

---

### Q64. Recommended monitoring service?

Amazon CloudWatch.

---

### Q65. Recommended DNS service?

Amazon Route 53.

---

## CI/CD

### Q66. Can Terraform be used in CI/CD?

Yes.

---

### Q67. Popular CI/CD tools?

- Jenkins
- GitHub Actions
- GitLab CI
- Azure DevOps

---

### Q68. Where should Terraform code be stored?

Git Repository.

---

### Q69. Which command runs before apply?

```bash
terraform plan
```

---

### Q70. Why review the execution plan?

To verify infrastructure changes before deployment.

---

## Interview Favorites

### Q71. What is Terraform Registry?

Repository of providers and reusable modules.

---

### Q72. What is the `.terraform` directory?

Stores downloaded providers and modules.

---

### Q73. What is `.terraform.lock.hcl`?

Locks provider versions.

---

### Q74. What is `terraform output`?

Displays output values.

---

### Q75. What is `terraform workspace`?

A feature for managing multiple state environments.

---

### Q76. What is `terraform graph`?

Generates the resource dependency graph.

---

### Q77. What is `terraform taint`?

Marks a resource for recreation. *(Deprecated in newer versions; use `-replace`.)*

---

### Q78. What is `terraform apply -auto-approve`?

Applies changes without confirmation.

---

### Q79. What is `terraform plan -out=tfplan`?

Saves the execution plan to a file.

---

### Q80. What is the biggest advantage of Terraform?

Consistent, automated, and repeatable infrastructure deployment.

---

# Last-Minute Revision Checklist

- Terraform Workflow
- State Management
- S3 + DynamoDB Backend
- Modules
- Variables & Outputs
- Providers
- Meta Arguments
- Workspaces
- AWS Resources
- IAM Roles
- ALB
- Auto Scaling
- CloudWatch
- Route 53
- Troubleshooting
- Scenario-Based Questions
- CI/CD Integration
- Best Practices
- Terraform Commands
- Interview Confidence

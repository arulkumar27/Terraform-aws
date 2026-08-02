# Terraform Real-Time Scenario Based Interview Questions

## Overview

This document contains real-world Terraform and AWS production scenarios commonly asked in DevOps, Cloud Engineer, and Platform Engineer interviews. The answers demonstrate a structured troubleshooting approach and production best practices.

---

# Scenario 1

## Your `terraform apply` fails. What is your approach?

### Answer

My approach is systematic:

1. Read the complete error message.
2. Identify the resource causing the failure.
3. Verify the Terraform configuration.
4. Check AWS Console or CLI for the resource status.
5. Run `terraform validate`.
6. Run `terraform plan`.
7. Fix the issue and re-run `terraform apply`.

I avoid making manual changes unless absolutely necessary.

---

# Scenario 2

## A teammate manually deleted an EC2 instance created by Terraform. What happens?

### Answer

Terraform detects the missing resource during the next `terraform plan`.

Since the desired configuration still includes the EC2 instance, Terraform plans to recreate it during the next `terraform apply`.

This situation is called **State Drift**.

---

# Scenario 3

## Your Terraform state file becomes corrupted. What will you do?

### Answer

If using a remote backend:

- Restore from S3 Versioning.
- Verify the latest valid state.
- Check DynamoDB lock status.
- Run `terraform plan`.

If no backup exists:

- Recover the infrastructure using `terraform import`.
- Avoid manually editing the state file unless absolutely required.

---

# Scenario 4

## Two engineers run `terraform apply` at the same time.

### Answer

In production, the state is stored in Amazon S3 with DynamoDB state locking.

The first engineer acquires the lock.

The second engineer waits until the lock is released, preventing state corruption.

---

# Scenario 5

## Your ALB shows all EC2 instances as unhealthy.

### Answer

I would check:

- Health Check Path
- Health Check Port
- Security Groups
- Target Group Configuration
- Application Status
- Web Server (Nginx/Apache)
- EC2 Logs
- CloudWatch Metrics

---

# Scenario 6

## An EC2 instance is running but not reachable through SSH.

### Answer

I would verify:

- Security Group (Port 22)
- Network ACL
- Public IP
- Internet Gateway
- Route Table
- Key Pair
- EC2 Status Checks
- Bastion Host (if private)

---

# Scenario 7

## Users cannot access the website.

### Answer

I would verify:

- Route 53
- DNS Resolution
- ACM Certificate
- CloudFront
- Application Load Balancer
- Target Group
- EC2
- Application Service
- Security Groups

---

# Scenario 8

## `terraform init` fails while configuring the backend.

### Answer

I would verify:

- S3 Bucket Name
- Region
- Bucket Permissions
- Backend Configuration
- AWS Credentials
- Network Connectivity

---

# Scenario 9

## Someone manually changed an AWS Security Group.

### Answer

Terraform detects the difference during `terraform plan`.

I would:

- Review the planned changes.
- Decide whether the manual change is valid.
- Update the Terraform code if required.
- Apply the configuration to restore the desired state.

---

# Scenario 10

## Terraform cannot delete a VPC.

### Answer

A VPC cannot be deleted while dependent resources exist.

I would check for:

- Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network Interfaces
- Load Balancers
- EC2 Instances

---

# Scenario 11

## CPU utilization reaches 90%.

### Answer

I would:

- Check CloudWatch metrics.
- Verify application logs.
- Check running processes.
- Review Auto Scaling status.
- Confirm ALB distribution.
- Scale if required.
- Identify the root cause.

---

# Scenario 12

## Terraform creates duplicate resources.

### Answer

Possible reasons:

- Wrong state file
- Different backend
- Resource removed from state
- Missing import

I would verify the state before applying any changes.

---

# Scenario 13

## You need to deploy the same infrastructure in Dev, QA, and Production.

### Answer

I would use:

- Reusable Modules
- Environment-specific `.tfvars`
- Remote Backend
- Separate State Files
- CI/CD Pipeline

---

# Scenario 14

## A Terraform deployment partially succeeds.

### Answer

I would:

- Review the failed resources.
- Run `terraform plan`.
- Verify the state.
- Fix configuration issues.
- Re-run `terraform apply`.

Terraform only creates the missing resources if the state is consistent.

---

# Scenario 15

## AWS credentials expire during deployment.

### Answer

I would:

- Re-authenticate using AWS CLI or IAM Identity Center.
- Verify credentials using:

```bash
aws sts get-caller-identity
```

Then rerun:

```bash
terraform apply
```

---

# Scenario 16

## The application suddenly becomes slow.

### Answer

I would check:

- CloudWatch Metrics
- CPU
- Memory
- Disk I/O
- RDS Performance
- ALB Latency
- Application Logs
- Auto Scaling Activity

---

# Scenario 17

## The S3 bucket already exists.

### Answer

Since S3 bucket names are globally unique, I would either:

- Use a unique bucket name.
- Import the existing bucket into Terraform state.

---

# Scenario 18

## The database becomes unreachable.

### Answer

I would verify:

- RDS Status
- Security Group
- Database Port
- DB Subnet Group
- Route Tables
- Application Configuration
- Network Connectivity

---

# Scenario 19

## A deployment accidentally destroys production resources.

### Answer

To avoid this:

- Review every `terraform plan`.
- Enable deletion protection.
- Use separate production state.
- Restrict permissions.
- Implement approval steps in CI/CD.

---

# Scenario 20

## Your interviewer asks, "How do you troubleshoot Terraform problems?"

### Answer

I follow a structured approach:

1. Read the complete error message.
2. Identify the affected resource.
3. Validate Terraform configuration.
4. Verify cloud resources.
5. Check Terraform state.
6. Review logs.
7. Run `terraform plan`.
8. Apply only after confirming the changes.

---

# Production Best Practices

- Use Remote Backend.
- Enable S3 Versioning.
- Enable DynamoDB Locking.
- Use IAM Roles.
- Follow Least Privilege.
- Use Reusable Modules.
- Never edit the state manually.
- Always review `terraform plan`.
- Separate environments.
- Use CI/CD for deployments.

---

# Interview Tips

When answering scenario-based questions:

- Explain your troubleshooting steps in order.
- Start with identifying the problem.
- Mention the AWS services involved.
- Explain how Terraform interacts with those services.
- End with the preventive measures you would implement to avoid similar issues in the future.

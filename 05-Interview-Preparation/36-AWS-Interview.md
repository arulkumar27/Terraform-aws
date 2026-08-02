# Terraform + AWS Interview Questions & Answers

## Overview

This document covers commonly asked interview questions related to deploying and managing AWS infrastructure using Terraform. It includes real-world scenarios, best practices, and production concepts.

---

# Q1. Which AWS services have you provisioned using Terraform?

**Answer:**

I have provisioned the following AWS services using Terraform:

- VPC
- Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- EC2 Instances
- IAM Roles
- S3 Buckets
- EBS Volumes
- RDS
- Application Load Balancer
- Auto Scaling Group
- Route 53
- CloudWatch
- ACM Certificates

---

# Q2. How do you create an EC2 instance using Terraform?

**Answer:**

Using the `aws_instance` resource.

Example

```hcl
resource "aws_instance" "web" {

  ami           = "ami-xxxxxxxx"

  instance_type = "t3.micro"

}
```

---

# Q3. How do you create a VPC?

**Answer:**

Using

```hcl
aws_vpc
```

Example

```hcl
resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

}
```

---

# Q4. How do you deploy resources into multiple Availability Zones?

**Answer:**

Create multiple subnets across different Availability Zones and reference them in services such as ALB, RDS Multi-AZ, and Auto Scaling Groups.

---

# Q5. How do you make an EC2 instance publicly accessible?

**Answer:**

- Place it in a public subnet.
- Attach an Internet Gateway.
- Associate a Route Table with `0.0.0.0/0` pointing to the Internet Gateway.
- Enable a public IP.
- Configure Security Group rules.

---

# Q6. Why should databases be placed in private subnets?

**Answer:**

To prevent direct internet access and improve security. Only application servers should communicate with the database through private networking.

---

# Q7. How do you create a Security Group?

**Answer:**

Using

```hcl
aws_security_group
```

with ingress and egress rules.

---

# Q8. How do you create an S3 bucket?

**Answer:**

Using

```hcl
aws_s3_bucket
```

along with versioning, encryption, and public access block resources.

---

# Q9. How do you enable encryption for an S3 bucket?

**Answer:**

Using

```hcl
aws_s3_bucket_server_side_encryption_configuration
```

and configuring SSE-S3 or SSE-KMS.

---

# Q10. Why do you enable Versioning on S3?

**Answer:**

To recover deleted or overwritten objects and improve protection against accidental changes.

---

# Q11. How do you create an IAM Role?

**Answer:**

Using

```hcl
aws_iam_role
```

along with an Assume Role Policy and the required policy attachments.

---

# Q12. Why do we attach IAM Roles to EC2 instead of Access Keys?

**Answer:**

IAM Roles provide temporary credentials managed by AWS, eliminating the need to store long-term access keys on the EC2 instance.

---

# Q13. How do you create an Application Load Balancer?

**Answer:**

Using the following Terraform resources:

- aws_lb
- aws_lb_target_group
- aws_lb_listener
- aws_lb_listener_rule

---

# Q14. What is the purpose of a Target Group?

**Answer:**

A Target Group contains backend resources that receive traffic from a Load Balancer and performs health checks.

---

# Q15. What happens when a target becomes unhealthy?

**Answer:**

The Load Balancer stops sending traffic to the unhealthy target and routes requests only to healthy targets.

---

# Q16. How do you provision RDS?

**Answer:**

Using

```hcl
aws_db_instance
```

along with:

- DB Subnet Group
- Parameter Group
- Security Group

---

# Q17. What is Multi-AZ?

**Answer:**

Multi-AZ creates a standby database in another Availability Zone to provide automatic failover and high availability.

---

# Q18. Difference between Multi-AZ and Read Replica?

| Multi-AZ | Read Replica |
|-----------|--------------|
| High Availability | Read Scaling |
| Automatic Failover | No Automatic Failover |
| Synchronous Replication | Asynchronous Replication |

---

# Q19. How do you configure Auto Scaling?

**Answer:**

Using:

- Launch Template
- Auto Scaling Group
- Scaling Policy
- CloudWatch Alarm

---

# Q20. Which metric is commonly used for Auto Scaling?

**Answer:**

```
CPUUtilization
```

---

# Q21. How do you monitor AWS resources?

**Answer:**

Using Amazon CloudWatch.

It monitors:

- CPU
- Memory (CloudWatch Agent)
- Disk
- Logs
- Network
- Alarms

---

# Q22. How do you create DNS records?

**Answer:**

Using

```hcl
aws_route53_record
```

---

# Q23. What is an Alias Record?

**Answer:**

An Alias Record is an AWS-specific DNS record that points directly to AWS resources such as ALB, CloudFront, or S3 without requiring an additional DNS lookup.

---

# Q24. How do you secure Terraform deployments in AWS?

**Answer:**

- IAM Roles
- Least Privilege
- Encrypted S3 Backend
- DynamoDB Locking
- KMS Encryption
- Private Subnets
- Security Groups
- Versioned State Files

---

# Q25. What is your typical production Terraform architecture?

**Answer:**

```
GitHub

↓

GitHub Actions / Jenkins

↓

Terraform

↓

AWS

├── VPC
├── Public Subnets
├── Private Subnets
├── Internet Gateway
├── NAT Gateway
├── ALB
├── Auto Scaling Group
├── EC2
├── IAM
├── RDS
├── S3
├── CloudWatch
└── Route53
```

---

# Scenario-Based Questions

### Scenario 1

**Your EC2 instance launches successfully, but you cannot access it through the internet. What will you check?**

**Answer:**

- Public subnet
- Internet Gateway
- Route Table
- Public IP
- Security Group
- Network ACL
- EC2 status

---

### Scenario 2

**Users report your application is down even though EC2 instances are running. What will you investigate?**

**Answer:**

- ALB Health Checks
- Target Group Status
- Security Groups
- Listener Configuration
- Application Logs
- CloudWatch Metrics

---

### Scenario 3

**Your Terraform deployment fails because the S3 bucket already exists. What will you do?**

**Answer:**

Import the bucket using:

```bash
terraform import aws_s3_bucket.main bucket-name
```

or choose a globally unique bucket name.

---

### Scenario 4

**You need to deploy the same infrastructure in Dev, QA, and Production. How would you do it?**

**Answer:**

- Reusable Modules
- Environment-specific tfvars files
- Remote Backend
- Separate Workspaces or separate state files

---

# Quick Revision

| AWS Service | Terraform Resource |
|--------------|-------------------|
| EC2 | aws_instance |
| VPC | aws_vpc |
| Subnet | aws_subnet |
| Security Group | aws_security_group |
| Internet Gateway | aws_internet_gateway |
| NAT Gateway | aws_nat_gateway |
| S3 | aws_s3_bucket |
| IAM | aws_iam_role |
| RDS | aws_db_instance |
| ALB | aws_lb |
| Auto Scaling | aws_autoscaling_group |
| CloudWatch | aws_cloudwatch_metric_alarm |
| Route 53 | aws_route53_record |

---

# Interview Tips

- Explain AWS concepts together with the Terraform resources used to implement them.
- When answering scenario questions, describe your troubleshooting steps in a logical order (network → security → application → monitoring).
- Highlight production best practices such as private subnets, IAM Roles, remote state with S3 and DynamoDB, encryption, and modular Terraform code.

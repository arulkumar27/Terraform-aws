# AWS IAM (Identity and Access Management)

## Overview

AWS Identity and Access Management (IAM) is the AWS service used to securely manage authentication and authorization. It controls **who can access AWS resources** and **what actions they are allowed to perform**.

Terraform enables IAM resources to be created and managed as Infrastructure as Code (IaC), ensuring secure, repeatable, and auditable access management.

---

# Why We Use IAM

- Secure AWS account access
- Implement least privilege access
- Create users and groups
- Assign permissions through policies
- Allow AWS services to communicate securely
- Enable temporary access using IAM Roles
- Improve security and compliance

---

# Real-Time Use Case

A company has different teams:

- DevOps Team
- Developers
- QA Team
- Security Team

Each team requires different permissions.

Example:

- Developers can launch EC2 instances.
- QA team can only read S3 buckets.
- DevOps team has infrastructure management permissions.
- EC2 instances use IAM Roles to access S3 without storing AWS credentials.

Terraform creates all IAM resources automatically.

---

# IAM Components

```
                 IAM
                  │
     ┌────────────┼────────────┐
     ▼            ▼            ▼
   Users       Groups        Roles
                  │
                  ▼
              Policies
```

---

# IAM Users

IAM Users represent individual people or applications that need AWS access.

Example

```
john

alice

developer01
```

Terraform

```hcl
resource "aws_iam_user" "developer" {

  name = "developer"

}
```

Best Practice

Do not use the AWS Root User for daily tasks.

---

# IAM Groups

Groups allow multiple users to share the same permissions.

Example

```
Developers

DevOps

QA

Security
```

Users inherit permissions from the group.

Terraform

```hcl
resource "aws_iam_group" "developers" {

  name = "Developers"

}
```

---

# IAM Policies

Policies define permissions.

They are JSON documents.

Example

```
Allow EC2

Allow S3

Deny IAM

Allow CloudWatch
```

Example Policy

```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Effect":"Allow",
      "Action":"ec2:*",
      "Resource":"*"
    }
  ]
}
```

Terraform

```hcl
resource "aws_iam_policy" "ec2" {

  name   = "EC2FullAccess"

  policy = file("policy.json")

}
```

---

# Managed Policies

AWS provides predefined policies.

Examples

```
AmazonS3FullAccess

AmazonEC2ReadOnlyAccess

AmazonEC2FullAccess

AdministratorAccess

CloudWatchFullAccess
```

Advantages

- Maintained by AWS
- Easy to use
- Automatically updated

Terraform

```hcl
resource "aws_iam_role_policy_attachment" "example" {

  role       = aws_iam_role.ec2.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}
```

---

# Inline Policies

Inline Policies are directly attached to a single IAM User, Group, or Role.

Advantages

- Unique permissions
- Cannot be shared
- Deleted automatically with the resource

Suitable for

- Special-purpose permissions

---

# IAM Roles

IAM Roles provide temporary permissions to AWS services or users.

Examples

- EC2 accessing S3
- Lambda accessing DynamoDB
- ECS accessing Secrets Manager
- EKS Worker Nodes
- CodeBuild accessing S3

Terraform

```hcl
resource "aws_iam_role" "ec2_role" {

  name = "EC2Role"

  assume_role_policy = file("assume-role.json")

}
```

---

# Assume Role Policy

Defines **who can assume the role**.

Example

```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Effect":"Allow",
      "Principal":{
        "Service":"ec2.amazonaws.com"
      },
      "Action":"sts:AssumeRole"
    }
  ]
}
```

Without an Assume Role Policy, AWS services cannot use the role.

---

# IAM Instance Profile

EC2 instances cannot directly attach an IAM Role.

Instead, AWS uses an **Instance Profile**.

```
EC2

↓

Instance Profile

↓

IAM Role

↓

S3 Access
```

Terraform

```hcl
resource "aws_iam_instance_profile" "ec2" {

  name = "EC2Profile"

  role = aws_iam_role.ec2_role.name

}
```

Attach to EC2

```hcl
iam_instance_profile = aws_iam_instance_profile.ec2.name
```

---

# Principle of Least Privilege

Always grant only the permissions required.

Bad Example

```
AdministratorAccess
```

Good Example

```
Only

s3:GetObject

s3:PutObject
```

Advantages

- Better security
- Lower attack surface
- Easier auditing

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_iam_user | Create IAM User |
| aws_iam_group | Create IAM Group |
| aws_iam_policy | Create IAM Policy |
| aws_iam_role | Create IAM Role |
| aws_iam_role_policy_attachment | Attach Policy to Role |
| aws_iam_group_membership | Add Users to Group |
| aws_iam_instance_profile | Attach Role to EC2 |

---

# Complete Example

```hcl
resource "aws_iam_role" "ec2_role" {

  name = "EC2Role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "s3_access" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

resource "aws_iam_instance_profile" "profile" {

  name = "EC2Profile"

  role = aws_iam_role.ec2_role.name

}
```

---

# Real Project Example

Architecture

```
Developer

↓

GitHub

↓

Terraform

↓

EC2

↓

IAM Role

↓

Amazon S3

↓

Application Files
```

Another Example

```
Lambda

↓

IAM Role

↓

DynamoDB

↓

Store Data
```

No AWS Access Keys are stored inside the application.

---

# Best Practices

- Never use the Root User for daily operations.
- Enable MFA for all IAM users.
- Use IAM Roles instead of Access Keys.
- Follow the Principle of Least Privilege.
- Rotate Access Keys regularly.
- Prefer AWS Managed Policies when appropriate.
- Use customer-managed policies for custom permissions.
- Audit permissions using IAM Access Analyzer.
- Remove unused users and policies.
- Tag IAM resources.

---

# Common Mistakes

- Using Root User for everyday tasks.
- Giving AdministratorAccess to everyone.
- Hardcoding AWS credentials in code.
- Sharing IAM Users among multiple people.
- Not enabling MFA.
- Leaving unused access keys active.

---

# Common Interview Questions

### What is IAM?

IAM is the AWS service used to manage authentication and authorization for AWS resources.

---

### Difference between IAM User and IAM Role?

| IAM User | IAM Role |
|----------|----------|
| Permanent identity | Temporary identity |
| Used by people/applications | Used by AWS services or temporary users |
| Has long-term credentials | Uses temporary security credentials |

---

### Difference between Managed Policy and Inline Policy?

| Managed Policy | Inline Policy |
|---------------|---------------|
| Reusable | Attached to one resource only |
| Can be shared | Cannot be shared |
| Managed independently | Deleted with the resource |

---

### Why do we use IAM Roles for EC2?

IAM Roles allow EC2 instances to securely access AWS services without storing Access Keys on the instance.

---

### What is an Instance Profile?

An Instance Profile is a container that allows an IAM Role to be attached to an EC2 instance.

---

### What is the Principle of Least Privilege?

Grant only the minimum permissions required to perform a specific task.

---

### Which Terraform resource creates an IAM Role?

```hcl
aws_iam_role
```

---

# Summary

AWS IAM provides secure identity and access management for users, groups, roles, and AWS services. Terraform automates IAM resource creation, ensuring consistent permission management, secure access control, and adherence to security best practices such as least privilege and role-based access.

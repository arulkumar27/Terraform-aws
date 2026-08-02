# AWS Security Groups

## Overview

A Security Group (SG) is a virtual firewall that controls inbound and outbound traffic for AWS resources such as EC2 instances, RDS databases, Load Balancers, and Elastic File System (EFS).

Security Groups are **stateful**, meaning if inbound traffic is allowed, the corresponding outbound response is automatically allowed.

Terraform manages Security Groups using Infrastructure as Code, making firewall rules reusable, version-controlled, and easy to maintain.

---

# Why We Use Security Groups

- Protect EC2 instances from unauthorized access.
- Allow only required ports.
- Restrict traffic between application layers.
- Secure databases from public access.
- Control communication between AWS resources.
- Improve overall infrastructure security.

---

# Real-Time Use Case

An e-commerce application uses a three-tier architecture.

- Users access the website through an Application Load Balancer (ALB).
- The ALB forwards requests to frontend EC2 instances.
- Frontend EC2 communicates with backend EC2.
- Backend EC2 communicates with an RDS database.

Security Groups ensure:

- Internet users can access only ports **80** and **443** on the ALB.
- Only the ALB can access frontend servers.
- Only frontend servers can access backend servers.
- Only backend servers can connect to the database on port **3306**.
- No direct internet access to backend or database servers.

---

# How Security Groups Work

Every Security Group contains:

- Inbound Rules
- Outbound Rules

Traffic is allowed only if a rule explicitly permits it.

Anything not allowed is automatically denied.

---

# Stateful Firewall

Security Groups are **stateful**.

Example:

You allow SSH (Port 22) from your laptop.

```
Laptop
   │
SSH (22)
   ▼
EC2 Instance
```

The response traffic is automatically allowed.

You do **not** need to create another outbound rule for the reply.

---

# Inbound Rules

Inbound rules control incoming traffic to the resource.

Example

| Protocol | Port | Source | Purpose |
|----------|------|---------|---------|
| TCP | 22 | My IP | SSH |
| TCP | 80 | 0.0.0.0/0 | HTTP |
| TCP | 443 | 0.0.0.0/0 | HTTPS |

Terraform Example

```hcl
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["YOUR_IP/32"]
}
```

---

# Outbound Rules

Outbound rules control traffic leaving the resource.

Default AWS behavior allows all outbound traffic.

Example

| Protocol | Destination |
|----------|-------------|
| All | 0.0.0.0/0 |

Terraform Example

```hcl
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
```

---

# CIDR Blocks

CIDR specifies which IP addresses can access your resource.

Examples

| CIDR | Meaning |
|-------|----------|
| 0.0.0.0/0 | Everyone |
| 192.168.1.0/24 | Private Network |
| 203.0.113.15/32 | Single IP Address |

Best Practice

Never expose SSH (22) to:

```
0.0.0.0/0
```

Instead

```
YOUR_PUBLIC_IP/32
```

---

# Common Ports

| Port | Service |
|-------|----------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 3306 | MySQL |
| 5432 | PostgreSQL |
| 6379 | Redis |
| 8080 | Jenkins |
| 9000 | SonarQube |
| 9090 | Prometheus |
| 3000 | Grafana |
| 6443 | Kubernetes API |

---

# Security Group for Web Server

Example

```hcl
resource "aws_security_group" "web" {

  name        = "web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Web-SG"
  }

}
```

---

# Separate Security Group Rules

Terraform also supports defining rules separately.

Example

```hcl
resource "aws_vpc_security_group_ingress_rule" "http" {

  security_group_id = aws_security_group.web.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  cidr_ipv4 = "0.0.0.0/0"

}
```

Advantages

- Cleaner code
- Easier updates
- Better module support
- Preferred for large projects

---

# Dynamic Rules

Terraform can create multiple rules using loops.

Example

```hcl
variable "ports" {
  default = [80,443]
}

resource "aws_security_group" "web" {

  name   = "web-sg"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {

    for_each = var.ports

    content {

      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }

  }

}
```

---

# Real Project Example

Application Architecture

```
Internet
     │
     ▼
Application Load Balancer
     │
     ▼
Frontend EC2
     │
     ▼
Backend EC2
     │
     ▼
RDS Database
```

Security Groups

### ALB SG

Allow

- HTTP (80)
- HTTPS (443)

From

```
0.0.0.0/0
```

---

### Frontend SG

Allow

Port 80

Source

```
ALB Security Group
```

---

### Backend SG

Allow

Port 8080

Source

```
Frontend Security Group
```

---

### Database SG

Allow

Port 3306

Source

```
Backend Security Group
```

This design prevents direct internet access to backend servers and databases.

---

# Best Practices

- Follow the Principle of Least Privilege.
- Avoid opening SSH to the internet.
- Use Security Group references instead of CIDR whenever possible.
- Separate Security Groups by application layer.
- Remove unused rules regularly.
- Use meaningful names and tags.
- Enable VPC Flow Logs for monitoring.
- Store Security Groups in reusable Terraform modules.

---

# Common Mistakes

- Allowing SSH from `0.0.0.0/0`.
- Allowing all ports unnecessarily.
- Mixing frontend and database rules in one Security Group.
- Using overly permissive CIDR blocks.
- Forgetting to remove temporary rules after troubleshooting.

---

# Common Interview Questions

### What is a Security Group?

A Security Group is a stateful virtual firewall that controls inbound and outbound traffic for AWS resources.

---

### Is Security Group stateful or stateless?

Stateful.

---

### What happens if you allow inbound SSH?

The return traffic is automatically allowed because Security Groups are stateful.

---

### Can one EC2 instance have multiple Security Groups?

Yes. An EC2 instance can be attached to multiple Security Groups.

---

### Can Security Groups deny traffic?

No.

Security Groups only contain **Allow** rules.

Anything not explicitly allowed is automatically denied.

---

### Difference between Security Group and NACL?

| Security Group | NACL |
|---------------|------|
| Stateful | Stateless |
| Instance Level | Subnet Level |
| Allow Rules Only | Allow and Deny Rules |
| More Common | Additional Layer of Security |

---

# Summary

AWS Security Groups provide instance-level firewall protection by controlling inbound and outbound traffic. Terraform enables Security Groups to be defined as code, ensuring consistent, secure, and reusable network configurations across environments.

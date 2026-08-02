# AWS VPC (Virtual Private Cloud)

## Overview

Amazon Virtual Private Cloud (VPC) is a logically isolated virtual network within AWS where you can securely launch and manage AWS resources. It provides complete control over networking, including IP address ranges, subnets, routing, internet connectivity, and security.

Terraform enables VPC infrastructure to be provisioned and managed as Infrastructure as Code (IaC), ensuring consistent, repeatable, and scalable network deployments.

---

# Why We Use VPC

- Create an isolated network in AWS
- Control IP address allocation
- Separate public and private resources
- Improve security
- Build production-ready architectures
- Connect to on-premises networks
- Control inbound and outbound traffic
- Enable secure communication between AWS services

---

# Real-Time Use Case

A company deploys a three-tier web application.

- Public Subnet hosts the Application Load Balancer.
- Private Subnet hosts Application Servers.
- Private Database Subnet hosts Amazon RDS.
- NAT Gateway allows private servers to access the internet for updates.
- Internet Gateway provides internet access to public resources.

Terraform provisions the complete network infrastructure automatically.

---

# VPC Architecture

```
                    Internet
                        │
                Internet Gateway
                        │
                ┌───────▼────────┐
                │      VPC       │
                │ 10.0.0.0/16    │
                └───────┬────────┘
                        │
        ┌───────────────┼────────────────┐
        ▼                                ▼
 Public Subnet                    Private Subnet
 10.0.1.0/24                      10.0.2.0/24
        │                                │
        ▼                                ▼
 Application LB                    EC2 Application
        │                                │
        └──────────────┐                 │
                       ▼                 ▼
                   NAT Gateway       Database Subnet
                                        │
                                        ▼
                                       RDS
```

---

# CIDR Block

CIDR (Classless Inter-Domain Routing) defines the IP address range for a VPC.

Example

```
10.0.0.0/16
```

Supports

```
65,536 IP Addresses
```

Example Subnets

```
10.0.1.0/24

10.0.2.0/24

10.0.3.0/24
```

Terraform

```hcl
cidr_block = "10.0.0.0/16"
```

---

# Public Subnet

A subnet with a route to the Internet Gateway.

Typical Resources

- Application Load Balancer
- Bastion Host
- Web Servers
- NAT Gateway

Terraform

```hcl
map_public_ip_on_launch = true
```

---

# Private Subnet

No direct internet access.

Typical Resources

- Application Servers
- Database Servers
- Internal APIs
- Kubernetes Worker Nodes

Terraform

```hcl
map_public_ip_on_launch = false
```

---

# Internet Gateway (IGW)

Provides internet access for public resources inside the VPC.

Terraform

```hcl
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

}
```

---

# NAT Gateway

Allows private subnet resources to access the internet without exposing them publicly.

Examples

- Install software updates
- Download packages
- Access external APIs

Requires

- Elastic IP
- Public Subnet

Terraform

```hcl
resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public.id

}
```

---

# Elastic IP

A static public IP address required by the NAT Gateway.

Terraform

```hcl
resource "aws_eip" "nat" {

  domain = "vpc"

}
```

---

# Route Table

Determines where network traffic should be sent.

Public Route Table

```
0.0.0.0/0

↓

Internet Gateway
```

Private Route Table

```
0.0.0.0/0

↓

NAT Gateway
```

Terraform

```hcl
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

}
```

---

# Route

Example

```hcl
resource "aws_route" "internet" {

  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.main.id

}
```

---

# Route Table Association

Associates a subnet with a Route Table.

```hcl
resource "aws_route_table_association" "public" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.public.id

}
```

---

# Network ACL (NACL)

Subnet-level firewall.

Characteristics

- Stateless
- Supports Allow and Deny Rules
- Applies to all resources in a subnet

Terraform

```hcl
resource "aws_network_acl" "main" {

  vpc_id = aws_vpc.main.id

}
```

---

# Security Group

Instance-level firewall.

Characteristics

- Stateful
- Allow Rules Only
- Attached directly to resources

Example

```
EC2

↓

Security Group

↓

Allow Port 80

Allow Port 443

Allow Port 22
```

---

# VPC Endpoints

Allow private communication between your VPC and AWS services without using the public internet.

Examples

- Amazon S3
- DynamoDB
- Systems Manager
- Secrets Manager

Advantages

- Improved Security
- Lower Latency
- No Internet Gateway Required

Terraform

```hcl
resource "aws_vpc_endpoint" "s3" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.ap-south-1.s3"

}
```

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_vpc | Create VPC |
| aws_subnet | Create Subnet |
| aws_internet_gateway | Internet Access |
| aws_nat_gateway | Private Internet Access |
| aws_eip | Elastic IP |
| aws_route_table | Routing |
| aws_route | Route Configuration |
| aws_route_table_association | Associate Route Table |
| aws_network_acl | Network ACL |
| aws_vpc_endpoint | Private AWS Service Access |

---

# Complete Example

```hcl
resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Production-VPC"
  }

}

resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

}
```

---

# Real Project Example

Architecture

```
                Internet
                    │
           Internet Gateway
                    │
            Public Subnet
                    │
      Application Load Balancer
                    │
            Frontend EC2
                    │
            Private Subnet
                    │
            Backend EC2
                    │
            Database Subnet
                    │
                  Amazon RDS
```

Benefits

- High Security
- Network Isolation
- Controlled Internet Access
- Multi-AZ Support
- Scalable Architecture

---

# Best Practices

- Use private subnets for application and database servers.
- Keep databases inaccessible from the internet.
- Use multiple Availability Zones.
- Enable VPC Flow Logs.
- Use NAT Gateway for outbound internet access.
- Apply least privilege security groups.
- Use VPC Endpoints where possible.
- Plan CIDR ranges carefully.
- Separate environments (Dev, Test, Prod) into different VPCs when appropriate.

---

# Common Mistakes

- Deploying databases in public subnets.
- Using one subnet for all resources.
- Forgetting Route Table Associations.
- Allowing unrestricted SSH access.
- Choosing overlapping CIDR blocks.
- Not enabling Flow Logs.
- Creating a NAT Gateway in a private subnet.

---

# Common Interview Questions

### What is a VPC?

A VPC is a logically isolated virtual network in AWS where you can securely launch and manage AWS resources.

---

### Difference between Public and Private Subnet?

| Public Subnet | Private Subnet |
|---------------|----------------|
| Has Internet Gateway route | No Internet Gateway route |
| Public IP available | No Public IP |
| Internet accessible | Not directly accessible |
| Hosts ALB, Bastion | Hosts App, DB |

---

### Difference between Internet Gateway and NAT Gateway?

| Internet Gateway | NAT Gateway |
|------------------|-------------|
| Public internet access | Outbound internet only |
| Used by public subnet | Used by private subnet |
| No Elastic IP required | Requires Elastic IP |

---

### Difference between Security Group and NACL?

| Security Group | NACL |
|---------------|------|
| Stateful | Stateless |
| Instance Level | Subnet Level |
| Allow Only | Allow & Deny |
| Applied to Resources | Applied to Subnets |

---

### What is a VPC Endpoint?

A VPC Endpoint enables private connectivity between a VPC and AWS services without traversing the public internet.

---

### Which Terraform resource creates a VPC?

```hcl
aws_vpc
```

---

# Summary

Amazon VPC provides secure, isolated networking for AWS resources by enabling custom IP addressing, subnetting, routing, internet connectivity, and access control. Terraform automates VPC deployment, making network infrastructure consistent, scalable, and suitable for production environments.

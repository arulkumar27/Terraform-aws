# AWS Elastic Load Balancer (ELB)

## Overview

AWS Elastic Load Balancing (ELB) automatically distributes incoming application traffic across multiple targets such as EC2 instances, containers, IP addresses, and Lambda functions. It improves application availability, scalability, and fault tolerance.

Terraform enables ELB resources to be provisioned and managed as Infrastructure as Code (IaC), allowing consistent and automated deployments.

---

# Why We Use Load Balancer

- Distribute incoming traffic
- Improve High Availability
- Prevent server overload
- Automatic failover
- Health monitoring
- SSL/TLS termination
- Support Auto Scaling
- Zero downtime deployments
- Increase application reliability

---

# Real-Time Use Case

A company hosts an e-commerce website.

- Thousands of users access the application.
- Traffic first reaches an Application Load Balancer.
- ALB distributes requests across multiple EC2 instances.
- If one EC2 instance becomes unhealthy, ALB automatically stops sending traffic to it.
- Auto Scaling launches new EC2 instances during traffic spikes.

Terraform provisions the complete load balancing infrastructure.

---

# Load Balancer Architecture

```
                 Internet
                     │
                     ▼
          Application Load Balancer
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
      EC2-1        EC2-2        EC2-3
```

---

# Types of Load Balancers

## 1. Application Load Balancer (ALB)

Layer

```
Layer 7 (HTTP / HTTPS)
```

Features

- HTTP
- HTTPS
- Path-based routing
- Host-based routing
- SSL Termination
- Web Applications
- Microservices
- Kubernetes Ingress

Suitable for

- Websites
- REST APIs
- Microservices

Terraform Resource

```hcl
resource "aws_lb" "alb" {

  load_balancer_type = "application"

}
```

---

## 2. Network Load Balancer (NLB)

Layer

```
Layer 4 (TCP / UDP)
```

Features

- Very High Performance
- Static IP
- Low Latency
- Millions of Requests

Suitable for

- Gaming
- Banking
- Financial Applications

Terraform

```hcl
load_balancer_type = "network"
```

---

## 3. Gateway Load Balancer (GWLB)

Layer

```
Layer 3
```

Purpose

- Security Appliances
- Firewalls
- Deep Packet Inspection
- Network Virtual Appliances

---

# Listeners

A Listener checks incoming requests on a specific port and forwards them to the appropriate Target Group.

Example

| Port | Protocol |
|------|----------|
| 80 | HTTP |
| 443 | HTTPS |

Terraform

```hcl
resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

}
```

---

# Target Group

A Target Group contains the backend resources that receive traffic.

Supported Targets

- EC2 Instances
- IP Addresses
- Lambda Functions

Terraform

```hcl
resource "aws_lb_target_group" "web" {

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

}
```

---

# Health Checks

The Load Balancer continuously checks whether targets are healthy.

Example

```
GET /

↓

HTTP 200

↓

Healthy
```

If the health check fails,

Traffic is automatically redirected to healthy targets.

Terraform

```hcl
health_check {

  path = "/"

  interval = 30

  healthy_threshold = 3

  unhealthy_threshold = 3

}
```

---

# Path-Based Routing

Routes traffic based on URL paths.

Example

```
example.com/products

↓

Product Service
```

```
example.com/orders

↓

Order Service
```

```
example.com/payments

↓

Payment Service
```

Terraform

```hcl
condition {

  path_pattern {

    values = ["/products/*"]

  }

}
```

---

# Host-Based Routing

Routes traffic based on the domain name.

Example

```
api.company.com

↓

API Servers
```

```
admin.company.com

↓

Admin Servers
```

```
shop.company.com

↓

Shopping Servers
```

Terraform

```hcl
condition {

  host_header {

    values = ["api.company.com"]

  }

}
```

---

# SSL/TLS Termination

HTTPS traffic is decrypted at the Load Balancer.

Requirements

- ACM Certificate
- HTTPS Listener

Benefits

- Better Security
- Simplified Certificate Management
- Reduced EC2 Workload

Terraform

```hcl
protocol = "HTTPS"
```

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_lb | Create Load Balancer |
| aws_lb_target_group | Backend Target Group |
| aws_lb_listener | Listener |
| aws_lb_listener_rule | Path/Host Routing Rules |
| aws_lb_target_group_attachment | Attach Targets |

---

# Complete Example

```hcl
resource "aws_lb" "alb" {

  name = "production-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

}

resource "aws_lb_target_group" "web" {

  name = "web-targets"

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.web.arn

  }

}
```

---

# Real Project Example

Architecture

```
                    Internet
                        │
                        ▼
             Application Load Balancer
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
     EC2-Frontend1  EC2-Frontend2  EC2-Frontend3
                        │
                        ▼
                 Backend EC2
                        │
                        ▼
                     Amazon RDS
```

Features

- High Availability
- Health Checks
- Auto Scaling Integration
- HTTPS Support
- Path-Based Routing
- Zero Downtime

---

# Best Practices

- Deploy ALB across multiple Availability Zones.
- Enable HTTPS using ACM certificates.
- Use Security Groups to restrict access.
- Configure health checks properly.
- Enable access logs.
- Integrate with Auto Scaling Groups.
- Use Path-Based Routing for microservices.
- Place backend servers in private subnets.
- Monitor ALB metrics using CloudWatch.

---

# Common Mistakes

- Deploying ALB in only one Availability Zone.
- Incorrect health check path.
- Forgetting Security Group rules.
- Not enabling HTTPS.
- Registering unhealthy targets.
- Exposing backend servers directly to the internet.

---

# Common Interview Questions

### What is a Load Balancer?

A Load Balancer distributes incoming traffic across multiple backend resources to improve availability, scalability, and fault tolerance.

---

### What are the types of AWS Load Balancers?

- Application Load Balancer (ALB)
- Network Load Balancer (NLB)
- Gateway Load Balancer (GWLB)

---

### Difference between ALB and NLB?

| ALB | NLB |
|------|------|
| Layer 7 | Layer 4 |
| HTTP/HTTPS | TCP/UDP |
| Path-Based Routing | No Path Routing |
| Host-Based Routing | No Host Routing |
| Web Applications | High-Performance Applications |

---

### What is a Target Group?

A Target Group is a collection of backend resources that receive traffic from a Load Balancer.

---

### Why are Health Checks important?

Health Checks ensure traffic is sent only to healthy targets, improving application availability.

---

### Which Terraform resource creates an Application Load Balancer?

```hcl
aws_lb
```

---

# Summary

AWS Elastic Load Balancing distributes application traffic across multiple backend resources, ensuring high availability, fault tolerance, and scalability. Terraform automates the deployment and management of Load Balancers, listeners, target groups, and routing rules, enabling reliable and production-ready application architectures.

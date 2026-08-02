# AWS Auto Scaling

## Overview

AWS Auto Scaling automatically adjusts the number of EC2 instances based on application demand. It ensures applications remain highly available during traffic spikes while reducing costs during low-traffic periods.

Terraform provisions Auto Scaling resources as Infrastructure as Code (IaC), enabling automated, repeatable, and production-ready scaling configurations.

---

# Why We Use Auto Scaling

- Automatically add EC2 instances during high traffic
- Remove unnecessary instances during low traffic
- Improve High Availability
- Reduce infrastructure costs
- Maintain application performance
- Replace unhealthy instances automatically
- Integrate with Load Balancers
- Support Zero Downtime deployments

---

# Real-Time Use Case

An e-commerce company experiences heavy traffic during festivals and sales.

Normal Day

- 2 EC2 Instances

Festival Sale

- 10 EC2 Instances

Late Night

- Back to 2 EC2 Instances

AWS Auto Scaling automatically launches and terminates EC2 instances based on CPU utilization, request count, or custom CloudWatch metrics.

Terraform creates the complete Auto Scaling infrastructure automatically.

---

# Auto Scaling Architecture

```
                    Internet
                        │
                        ▼
            Application Load Balancer
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
     EC2-1           EC2-2          EC2-3
        ▲                               │
        │                               ▼
        └──────── Auto Scaling Group ───┘
```

---

# Launch Template

A Launch Template defines how new EC2 instances should be created.

It contains:

- AMI
- Instance Type
- Key Pair
- Security Groups
- IAM Role
- User Data
- EBS Configuration

Terraform

```hcl
resource "aws_launch_template" "web" {

  name_prefix   = "web-template"

  image_id      = "ami-xxxxxxxx"

  instance_type = "t2.micro"

}
```

---

# Launch Configuration

Launch Configuration is the older method for defining EC2 configuration.

Status

- Legacy
- AWS recommends Launch Templates instead.

Terraform

```hcl
resource "aws_launch_configuration" "web" {

}
```

For new deployments, always use **Launch Templates**.

---

# Auto Scaling Group (ASG)

An Auto Scaling Group manages a collection of EC2 instances.

Responsibilities

- Launch new instances
- Remove unnecessary instances
- Replace unhealthy instances
- Maintain desired capacity
- Distribute instances across Availability Zones

Terraform

```hcl
resource "aws_autoscaling_group" "web" {

}
```

---

# Desired Capacity

The number of EC2 instances that should always be running.

Example

```
Desired Capacity = 2
```

AWS ensures two healthy instances remain available.

---

# Minimum Capacity

The minimum number of EC2 instances.

Example

```
Minimum = 2
```

Even during low traffic,

AWS never goes below two instances.

---

# Maximum Capacity

Maximum number of EC2 instances allowed.

Example

```
Maximum = 10
```

Even during traffic spikes,

AWS never launches more than ten instances.

---

# Scaling Policies

Scaling Policies determine when Auto Scaling should add or remove instances.

Types

- Target Tracking
- Step Scaling
- Simple Scaling
- Scheduled Scaling

---

# Target Tracking Scaling

Maintains a specific CloudWatch metric.

Example

```
Target CPU

50%
```

If CPU

```
> 50%
```

AWS launches more instances.

If CPU

```
< 50%
```

AWS terminates unnecessary instances.

Terraform

```hcl
resource "aws_autoscaling_policy" "cpu" {

  policy_type = "TargetTrackingScaling"

}
```

---

# Step Scaling

Adds or removes a fixed number of instances based on CloudWatch alarms.

Example

```
CPU > 70%

↓

Add 2 Instances
```

```
CPU > 90%

↓

Add 4 Instances
```

Suitable for predictable workloads.

---

# Scheduled Scaling

Automatically scales based on time.

Example

```
Every Morning 9 AM

↓

Launch 6 Instances
```

```
Every Night 11 PM

↓

Reduce to 2 Instances
```

Useful for

- Office Applications
- Batch Processing
- Business Hours

---

# Health Checks

Auto Scaling continuously checks EC2 health.

If an instance becomes unhealthy,

```
Terminate

↓

Launch New Instance
```

Health Sources

- EC2 Status Checks
- Application Load Balancer Health Checks

---

# CloudWatch Integration

CloudWatch provides metrics used by Auto Scaling.

Common Metrics

- CPU Utilization
- Request Count
- Network Traffic
- Memory (Custom Metric)
- Disk Utilization

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_launch_template | EC2 Template |
| aws_autoscaling_group | Auto Scaling Group |
| aws_autoscaling_policy | Scaling Policy |
| aws_cloudwatch_metric_alarm | Trigger Scaling |

---

# Complete Example

```hcl
resource "aws_launch_template" "web" {

  name_prefix   = "web"

  image_id      = "ami-xxxxxxxx"

  instance_type = "t2.micro"

}

resource "aws_autoscaling_group" "web" {

  min_size         = 2

  max_size         = 5

  desired_capacity = 2

  vpc_zone_identifier = [

    aws_subnet.private1.id,

    aws_subnet.private2.id

  ]

  launch_template {

    id      = aws_launch_template.web.id

    version = "$Latest"

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
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
       EC2-1         EC2-2         EC2-3
          ▲                             │
          │                             ▼
        Auto Scaling Group (2–10 Instances)
                         │
                         ▼
                      Amazon RDS
```

Scenario

- Normal traffic → 2 instances
- Sale starts → CPU reaches 75%
- Auto Scaling launches 4 additional instances
- Traffic decreases → Extra instances are terminated automatically

---

# Best Practices

- Use Launch Templates instead of Launch Configurations.
- Deploy across multiple Availability Zones.
- Integrate with Application Load Balancer.
- Configure Health Checks properly.
- Use Target Tracking for most workloads.
- Set realistic minimum and maximum capacities.
- Enable detailed CloudWatch monitoring.
- Store application code in User Data or AMIs.
- Use lifecycle hooks for graceful instance termination.

---

# Common Mistakes

- Setting minimum capacity to 0 for production.
- Using Launch Configurations for new projects.
- Forgetting to attach the Auto Scaling Group to a Target Group.
- Poor health check configuration.
- Very aggressive scaling policies causing constant scaling events.
- Not using multiple Availability Zones.

---

# Common Interview Questions

### What is AWS Auto Scaling?

AWS Auto Scaling automatically launches or terminates EC2 instances based on application demand.

---

### What is a Launch Template?

A Launch Template defines the configuration used when creating new EC2 instances, including AMI, instance type, security groups, and user data.

---

### Difference between Launch Template and Launch Configuration?

| Launch Template | Launch Configuration |
|-----------------|----------------------|
| Recommended | Legacy |
| Supports newer EC2 features | Limited features |
| Versioning supported | No versioning |
| AWS recommended | Deprecated for new deployments |

---

### What is Desired Capacity?

Desired Capacity is the number of EC2 instances that the Auto Scaling Group attempts to maintain at all times.

---

### Difference between Min, Max, and Desired Capacity?

| Setting | Purpose |
|----------|----------|
| Minimum | Lowest number of instances |
| Maximum | Highest number of instances |
| Desired | Current target number of instances |

---

### Which CloudWatch metric is commonly used for Auto Scaling?

```
CPUUtilization
```

---

### Which Terraform resource creates an Auto Scaling Group?

```hcl
aws_autoscaling_group
```

---

# Summary

AWS Auto Scaling automatically adjusts the number of EC2 instances based on application demand, ensuring high availability, improved performance, and cost optimization. Terraform automates the deployment of Launch Templates, Auto Scaling Groups, and scaling policies, enabling resilient and production-ready cloud architectures.

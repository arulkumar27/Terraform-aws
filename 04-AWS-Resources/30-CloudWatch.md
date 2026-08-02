# Amazon CloudWatch

## Overview

Amazon CloudWatch is AWS's monitoring and observability service used to collect, monitor, analyze, and visualize metrics, logs, and events from AWS resources and applications. It helps detect issues, trigger automated actions, and maintain the health of cloud infrastructure.

Terraform allows CloudWatch resources such as alarms, dashboards, log groups, and metric filters to be managed as Infrastructure as Code (IaC).

---

# Why We Use CloudWatch

- Monitor AWS resources
- Monitor application performance
- Detect failures automatically
- Generate alerts
- Centralized logging
- Performance troubleshooting
- Auto Scaling integration
- Build monitoring dashboards
- Improve system reliability

---

# Real-Time Use Case

A company hosts an e-commerce application.

Infrastructure

- Application Load Balancer
- Auto Scaling Group
- EC2 Instances
- Amazon RDS
- S3
- Lambda

CloudWatch continuously monitors:

- EC2 CPU utilization
- Memory usage
- Disk utilization
- ALB request count
- RDS connections
- Application logs

If CPU exceeds 80%, CloudWatch triggers an Auto Scaling policy to launch additional EC2 instances.

---

# CloudWatch Architecture

```
                 AWS Resources
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
      EC2             RDS            ALB
        │              │              │
        └──────────────┼──────────────┘
                       ▼
                 Amazon CloudWatch
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
     Metrics        Logs          Alarms
                       │
                       ▼
                SNS Notifications
```

---

# CloudWatch Metrics

Metrics are numerical measurements collected over time.

Examples

- CPU Utilization
- Network In
- Network Out
- Disk Read Operations
- Disk Write Operations
- Status Checks
- Request Count
- Latency
- Database Connections

Example

```
EC2 CPU

15%

↓

40%

↓

82%

↓

Alarm Triggered
```

---

# CloudWatch Logs

CloudWatch Logs stores application and system logs.

Examples

- Application Logs
- Nginx Logs
- Apache Logs
- Docker Logs
- Lambda Logs
- System Logs

Benefits

- Centralized logging
- Easier troubleshooting
- Searchable logs
- Long-term retention

Terraform

```hcl
resource "aws_cloudwatch_log_group" "application" {

  name = "/application/logs"

  retention_in_days = 30

}
```

---

# Log Groups

A Log Group is a collection of related log streams.

Example

```
/ec2/application

/lambda/orders

/eks/production

/rds/mysql
```

---

# Log Streams

A Log Stream represents logs from a single source.

Example

```
Application Log Group

↓

EC2-1 Logs

↓

EC2-2 Logs

↓

EC2-3 Logs
```

---

# CloudWatch Alarms

CloudWatch Alarms continuously evaluate metrics.

Example

```
CPU > 80%

↓

Alarm State

↓

Send Notification

↓

Launch New EC2
```

Terraform

```hcl
resource "aws_cloudwatch_metric_alarm" "cpu" {

  alarm_name = "HighCPU"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 80

}
```

---

# CloudWatch Dashboard

Dashboards provide a centralized view of infrastructure.

Monitor

- EC2
- RDS
- ALB
- Lambda
- S3
- Auto Scaling

Terraform

```hcl
resource "aws_cloudwatch_dashboard" "production" {

  dashboard_name = "Production-Dashboard"

}
```

---

# SNS Notifications

CloudWatch Alarms commonly integrate with Amazon SNS.

Flow

```
CloudWatch Alarm

↓

Amazon SNS

↓

Email

SMS

Lambda

Slack
```

Example

```
CPU > 80%

↓

Email DevOps Team
```

---

# CloudWatch Agent

CloudWatch Agent collects additional operating system metrics.

Collects

- Memory Usage
- Disk Usage
- Disk IOPS
- Swap Usage
- Processes
- Custom Metrics

Installed on

- EC2
- On-Premises Servers

---

# Custom Metrics

Applications can publish custom metrics.

Examples

- Active Users
- Orders Per Minute
- Login Failures
- Payment Success Rate

Useful for business monitoring.

---

# CloudWatch Events / EventBridge

CloudWatch Events has evolved into Amazon EventBridge.

Uses

- Schedule Lambda
- Trigger Automation
- Respond to Infrastructure Events
- Automate Operations

Example

```
EC2 Stops

↓

Trigger Lambda

↓

Restart Instance
```

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_cloudwatch_metric_alarm | Create Alarm |
| aws_cloudwatch_log_group | Store Logs |
| aws_cloudwatch_dashboard | Dashboard |
| aws_cloudwatch_log_metric_filter | Create Metrics from Logs |
| aws_cloudwatch_event_rule | Event Scheduling |
| aws_cloudwatch_event_target | Event Target |

---

# Complete Example

```hcl
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name = "HighCPU"

  namespace = "AWS/EC2"

  metric_name = "CPUUtilization"

  statistic = "Average"

  period = 300

  evaluation_periods = 2

  threshold = 80

  comparison_operator = "GreaterThanThreshold"

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
                    ▼
             Auto Scaling Group
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
     EC2-1       EC2-2       EC2-3
        │           │           │
        └───────────┼───────────┘
                    ▼
              CloudWatch
        ┌───────────┼───────────┐
        ▼           ▼           ▼
     Metrics      Logs      Alarms
                    │
                    ▼
                   SNS
                    │
                    ▼
              DevOps Engineer
```

Scenario

- CPU reaches 85%.
- CloudWatch Alarm changes to **ALARM** state.
- SNS sends an email notification.
- Auto Scaling launches two new EC2 instances.
- Traffic is distributed automatically by the ALB.
- Once CPU falls below the threshold, Auto Scaling removes unnecessary instances.

---

# Best Practices

- Enable detailed monitoring for production workloads.
- Monitor business-critical metrics.
- Configure alarms for CPU, memory, and storage.
- Set log retention policies.
- Create dashboards for production environments.
- Integrate CloudWatch with SNS.
- Use CloudWatch Agent for OS-level metrics.
- Avoid creating unnecessary alarms.
- Review alarms periodically.

---

# Common Mistakes

- Not monitoring memory usage.
- Creating too many unnecessary alarms.
- Forgetting log retention settings.
- Ignoring alarm notifications.
- Using default thresholds for every workload.
- Not enabling detailed monitoring.

---

# Common Interview Questions

### What is Amazon CloudWatch?

Amazon CloudWatch is AWS's monitoring and observability service used to collect metrics, logs, events, and alarms from AWS resources and applications.

---

### What are CloudWatch Metrics?

Metrics are time-based numerical measurements such as CPU utilization, network traffic, and disk operations.

---

### What is a CloudWatch Alarm?

A CloudWatch Alarm monitors a metric and performs an action when a defined threshold is reached.

---

### Difference between CloudWatch Logs and Metrics?

| Metrics | Logs |
|----------|------|
| Numerical Data | Text Data |
| CPU, Memory, Network | Application & System Logs |
| Used for Monitoring | Used for Troubleshooting |

---

### What is the purpose of CloudWatch Agent?

CloudWatch Agent collects operating system metrics such as memory usage, disk usage, and custom metrics that are not available by default.

---

### Which Terraform resource creates a CloudWatch Alarm?

```hcl
aws_cloudwatch_metric_alarm
```

---

# Summary

Amazon CloudWatch is AWS's centralized monitoring and observability service that collects metrics, logs, and events from cloud resources and applications. Terraform automates the creation of CloudWatch alarms, dashboards, log groups, and monitoring infrastructure, enabling proactive monitoring, automated scaling, and faster incident response.
```

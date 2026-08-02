# Amazon RDS (Relational Database Service)

## Overview

Amazon Relational Database Service (RDS) is a fully managed database service provided by AWS. It simplifies database administration by automating tasks such as provisioning, backups, software patching, monitoring, and scaling.

Terraform allows you to provision RDS databases as Infrastructure as Code (IaC), ensuring consistent and repeatable deployments across multiple environments.

---

# Why We Use RDS

- Managed relational database
- Automatic backups
- High Availability
- Multi-AZ deployment
- Read Replicas
- Automatic patching
- Easy scaling
- Encryption
- Monitoring with CloudWatch
- Disaster Recovery

---

# Real-Time Use Case

A company hosts an e-commerce application.

- Frontend runs on EC2.
- Backend APIs communicate with MySQL RDS.
- Database is deployed in private subnets.
- Multi-AZ is enabled for High Availability.
- Automated backups run every day.
- Read Replicas serve reporting queries.

Terraform provisions the complete database infrastructure.

---

# RDS Architecture

```
                 Users
                   │
                   ▼
          Application Load Balancer
                   │
                   ▼
               EC2 Backend
                   │
                   ▼
             Amazon RDS MySQL
                   │
         ┌─────────┴─────────┐
         ▼                   ▼
   Primary Database     Standby Database
      (AZ-1)               (AZ-2)
```

---

# Supported Database Engines

Amazon RDS supports multiple database engines.

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server

Terraform Example

```hcl
engine = "mysql"
```

---

# Engine Version

Specifies the database version.

Example

```hcl
engine_version = "8.0"
```

Always use supported and stable versions.

---

# DB Instance

Represents the actual database server.

Terraform Resource

```hcl
resource "aws_db_instance" "main" {

}
```

---

# DB Instance Class

Determines CPU and memory.

Examples

| Instance Class | Usage |
|---------------|-------|
| db.t3.micro | Free Tier |
| db.t3.small | Development |
| db.t3.medium | Small Production |
| db.m5.large | Production |
| db.r5.large | Memory Intensive |

Terraform

```hcl
instance_class = "db.t3.micro"
```

---

# Storage

Specifies allocated database storage.

Example

```hcl
allocated_storage = 20
```

Storage Type

- gp3
- gp2
- io1
- io2

Recommended

```
gp3
```

---

# Multi-AZ Deployment

Provides High Availability.

```
Primary Database

↓

Automatic Replication

↓

Standby Database
```

If the primary database fails,

AWS automatically switches to the standby database.

Terraform

```hcl
multi_az = true
```

---

# Read Replica

Used for read-heavy workloads.

```
Application

      │

      ▼

Primary Database

      │

 ┌────┴─────┐

 ▼          ▼

Read-1   Read-2
```

Advantages

- Improves performance
- Reduces database load
- Reporting
- Analytics

---

# DB Subnet Group

Defines where RDS is deployed.

Usually contains

```
Private Subnet AZ-1

Private Subnet AZ-2
```

Terraform

```hcl
resource "aws_db_subnet_group" "main" {

  name = "database-subnet"

}
```

Best Practice

Always deploy databases inside private subnets.

---

# Parameter Group

Controls database configuration.

Examples

- max_connections
- log_connections
- slow_query_log
- character_set_server

Terraform

```hcl
resource "aws_db_parameter_group" "main" {

}
```

---

# Option Group

Provides additional database features.

Examples

Oracle

- TDE
- OEM

SQL Server

- Backup

MySQL

- Audit Plugins

Terraform

```hcl
resource "aws_db_option_group" "main" {

}
```

---

# Backup

Automated backups protect against accidental data loss.

Terraform

```hcl
backup_retention_period = 7
```

Best Practice

Production

```
7–35 Days
```

Development

```
1–3 Days
```

---

# Maintenance Window

Specifies when AWS performs updates.

Terraform

```hcl
maintenance_window = "Mon:03:00-Mon:04:00"
```

Choose low-traffic hours.

---

# Encryption

Encrypts database storage.

Terraform

```hcl
storage_encrypted = true
```

Recommended for all production databases.

---

# Monitoring

Amazon RDS integrates with CloudWatch.

Monitor

- CPU Utilization
- Memory
- Storage
- Connections
- Read Latency
- Write Latency
- Disk Queue Depth

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_db_instance | Create Database |
| aws_db_subnet_group | Database Network |
| aws_db_parameter_group | Database Configuration |
| aws_db_option_group | Database Features |

---

# Complete Example

```hcl
resource "aws_db_instance" "mysql" {

  identifier = "production-db"

  engine = "mysql"

  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  storage_type = "gp3"

  username = "admin"

  password = "ChangeMe123!"

  multi_az = true

  storage_encrypted = true

  backup_retention_period = 7

  publicly_accessible = false

  skip_final_snapshot = true

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
Frontend EC2
     │
     ▼
Backend EC2
     │
     ▼
Amazon RDS MySQL
     │
     ▼
Automatic Backup
     │
     ▼
Read Replica
```

Benefits

- High Availability
- Automatic Failover
- Secure Database
- Easy Maintenance
- Managed Service

---

# Best Practices

- Deploy RDS in private subnets.
- Enable Multi-AZ for production.
- Enable automatic backups.
- Encrypt database storage.
- Use Security Groups to restrict access.
- Rotate database passwords regularly.
- Use Read Replicas for read-heavy applications.
- Monitor performance with CloudWatch.
- Use Parameter Groups for database tuning.
- Never expose databases directly to the internet.

---

# Common Mistakes

- Deploying RDS in public subnets.
- Disabling backups.
- Using weak passwords.
- Hardcoding database credentials in Terraform.
- Not enabling encryption.
- Forgetting to enable deletion protection in production.
- Allowing unrestricted database ports (3306, 5432).

---

# Common Interview Questions

### What is Amazon RDS?

Amazon RDS is a fully managed relational database service that automates database administration tasks such as provisioning, backups, patching, monitoring, and scaling.

---

### Which databases are supported by Amazon RDS?

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server

---

### What is Multi-AZ?

Multi-AZ creates a synchronous standby database in another Availability Zone to provide automatic failover and high availability.

---

### Difference between Multi-AZ and Read Replica?

| Multi-AZ | Read Replica |
|-----------|--------------|
| High Availability | Read Scaling |
| Automatic Failover | No Automatic Failover |
| Synchronous Replication | Asynchronous Replication |
| Disaster Recovery | Performance Improvement |

---

### Why should RDS be deployed in private subnets?

To prevent direct internet access and improve database security.

---

### Which Terraform resource creates an RDS instance?

```hcl
aws_db_instance
```

---

# Summary

Amazon RDS is a fully managed relational database service that simplifies database administration while providing high availability, backups, encryption, and scalability. Terraform automates the provisioning and management of RDS infrastructure, enabling secure, repeatable, and production-ready database deployments.
```

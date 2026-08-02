# Amazon EBS (Elastic Block Store)

## Overview

Amazon Elastic Block Store (EBS) is a block-level storage service that provides persistent storage for Amazon EC2 instances. It behaves like a physical hard disk attached to a virtual server and retains data even if the EC2 instance is stopped.

Terraform allows you to create, attach, encrypt, resize, and manage EBS volumes as Infrastructure as Code.

---

# Why We Use EBS

- Store operating system files
- Store application data
- Host databases
- Persistent storage for EC2
- High-performance storage
- Create backups using snapshots
- Resize storage without recreating EC2

---

# Real-Time Use Case

A company hosts a MySQL database on an EC2 instance.

- EC2 runs the database server.
- Database files are stored on a 500 GB EBS volume.
- Daily snapshots are taken automatically.
- If the EC2 instance fails, the EBS volume is attached to a new EC2 instance without losing data.

Terraform provisions both the EC2 instance and its EBS storage.

---

# How EBS Works

```
             EC2 Instance
                  │
                  │
        ┌─────────▼─────────┐
        │     EBS Volume    │
        │   Persistent Disk │
        └───────────────────┘
```

The EBS volume behaves like a hard disk connected to the EC2 instance.

---

# Features

- Persistent Storage
- High Availability within an Availability Zone
- Encryption
- Snapshots
- Resize Volume
- High Performance
- Multiple Volume Types
- Attach and Detach

---

# Volume Types

## gp3 (General Purpose SSD)

Most commonly used volume type.

Suitable for

- Web Servers
- Application Servers
- Development
- Production

Advantages

- Low cost
- High performance
- Independent IOPS and throughput
- Recommended for most workloads

Terraform Example

```hcl
volume_type = "gp3"
```

---

## gp2 (General Purpose SSD)

Older SSD volume.

Mostly replaced by gp3.

---

## io1

Provisioned IOPS SSD.

Suitable for

- High-performance databases
- Oracle
- SQL Server

Advantages

- Very high IOPS

---

## io2

Improved version of io1.

Advantages

- Better durability
- Higher availability
- Mission-critical workloads

---

## st1

Throughput Optimized HDD.

Suitable for

- Big Data
- Log Processing
- Data Warehouses

Not recommended for operating systems.

---

## sc1

Cold HDD Storage.

Suitable for

- Archive
- Backup
- Rarely accessed files

Cheapest EBS storage.

---

# Root Volume

Every EC2 instance launches with a root volume.

Example

```
Ubuntu EC2

20 GB gp3
```

Contains

- Operating System
- Installed Packages
- Boot Files
- Application Files

Terraform Example

```hcl
root_block_device {

  volume_size = 30
  volume_type = "gp3"

}
```

---

# Additional EBS Volume

Extra storage attached to EC2.

Example

```
EC2

├── Root Volume (30 GB)
└── Data Volume (200 GB)
```

Useful for

- Database Storage
- Logs
- Docker Volumes
- Application Data

---

# Create EBS Volume

Terraform Resource

```hcl
resource "aws_ebs_volume" "data" {

  availability_zone = "ap-south-1a"

  size = 100

  type = "gp3"

  encrypted = true

  tags = {
    Name = "Database-Volume"
  }

}
```

---

# Attach EBS Volume

Terraform Resource

```hcl
resource "aws_volume_attachment" "data" {

  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.data.id

  instance_id = aws_instance.database.id

}
```

---

# Encryption

Encrypts data stored on the volume.

Terraform Example

```hcl
encrypted = true
```

Advantages

- Secure storage
- Compliance
- Automatic encryption using AWS KMS

---

# Snapshots

Snapshots create backups of EBS volumes.

Advantages

- Disaster Recovery
- Backup
- Restore
- Clone Volumes

Terraform Resource

```hcl
resource "aws_ebs_snapshot" "backup" {

  volume_id = aws_ebs_volume.data.id

  tags = {
    Name = "Daily-Backup"
  }

}
```

---

# Resize Volume

EBS volumes can be expanded without recreating the EC2 instance.

Example

```
20 GB

↓

50 GB

↓

100 GB
```

Useful when application storage requirements increase.

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_ebs_volume | Create EBS Volume |
| aws_volume_attachment | Attach Volume |
| aws_ebs_snapshot | Create Snapshot |

---

# Complete Example

```hcl
resource "aws_instance" "server" {

  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"

}

resource "aws_ebs_volume" "storage" {

  availability_zone = "ap-south-1a"

  size = 100

  type = "gp3"

  encrypted = true

  tags = {
    Name = "App-Storage"
  }

}

resource "aws_volume_attachment" "storage" {

  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.storage.id

  instance_id = aws_instance.server.id

}
```

---

# Real Project Example

Architecture

```
Application Load Balancer
          │
          ▼
      EC2 Web Server
          │
          ▼
     50 GB Root Volume

          │

          ▼

    500 GB gp3 EBS Volume

          │

          ▼

Application Logs
User Uploads
Docker Volumes
```

Benefits

- Operating system and application data are separated.
- Storage can be increased without affecting the EC2 instance.
- Daily snapshots protect against data loss.

---

# Best Practices

- Use gp3 for most workloads.
- Enable encryption for all production volumes.
- Take regular snapshots.
- Separate OS and application data.
- Use tags for easy identification.
- Monitor storage utilization using CloudWatch.
- Delete unused EBS volumes to reduce costs.
- Use io2 only for high-performance databases.

---

# Common Mistakes

- Forgetting to enable encryption.
- Leaving unattached EBS volumes running (incurs cost).
- Using gp2 instead of gp3 for new deployments.
- Not taking snapshots before major changes.
- Storing application data only on the root volume.

---

# Common Interview Questions

### What is Amazon EBS?

Amazon EBS is a persistent block storage service for Amazon EC2 instances.

---

### Is EBS persistent?

Yes. Data remains even after the EC2 instance is stopped.

---

### Can an EBS volume be attached to multiple EC2 instances?

Normally, one EBS volume can be attached to only one EC2 instance at a time (except specific Multi-Attach supported volume types).

---

### Difference between EBS and Instance Store?

| EBS | Instance Store |
|------|----------------|
| Persistent | Temporary |
| Can create snapshots | No snapshots |
| Can be detached and attached | Cannot be detached |
| Network-attached | Physically attached to host |

---

### Which EBS volume type is recommended for most workloads?

gp3.

---

### Which Terraform resource creates an EBS volume?

```hcl
aws_ebs_volume
```

---

# Summary

Amazon EBS provides durable, high-performance block storage for EC2 instances. Terraform automates the provisioning, attachment, encryption, and backup of EBS volumes, ensuring scalable and reliable storage management across AWS environments.

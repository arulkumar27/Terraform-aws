# Production-Grade AWS Three-Tier Infrastructure Using Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.8+-7B42BC?logo=terraform\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Production_Infrastructure-FF9900?logo=amazonaws\&logoColor=white)
![Infrastructure as Code](https://img.shields.io/badge/Infrastructure-as_Code-blue)
![Architecture](https://img.shields.io/badge/Architecture-Three_Tier-success)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This project provisions a secure, highly available, scalable, and production-oriented three-tier AWS infrastructure using Terraform.

The infrastructure is organized into reusable Terraform modules and supports isolated development, staging, and production environments. It demonstrates Infrastructure as Code practices commonly used by Cloud and DevOps teams to provision and manage AWS infrastructure consistently.

The architecture includes public and private subnets across multiple Availability Zones, an internet-facing Application Load Balancer, Auto Scaling EC2 application servers, a private Amazon RDS database, encrypted storage, centralized monitoring, alerting, DNS management, TLS certificates, remote Terraform state, and security controls.

---

## Project Objectives

The primary objectives of this project are to:

* Provision AWS infrastructure using Terraform.
* Implement a reusable modular Terraform architecture.
* deploy resources across multiple Availability Zones.
* Separate public, application, and database network layers.
* Place application servers and databases in private subnets.
* distribute traffic using an Application Load Balancer.
* Automatically scale EC2 instances based on demand.
* Replace unhealthy EC2 instances automatically.
* Provision a private and encrypted Amazon RDS database.
* Apply least-privilege security controls.
* Store Terraform state remotely.
* Protect the state against simultaneous modification.
* Enable centralized monitoring and alerting.
* Support development, staging, and production environments.
* Apply consistent naming and tagging across resources.

---

## Architecture

```text
                                      Internet
                                          │
                                          ▼
                                  Amazon Route 53
                                          │
                                          ▼
                                  ACM TLS Certificate
                                          │
                                          ▼
                           Application Load Balancer
                              Public Subnets in 2 AZs
                                          │
                         ┌────────────────┴────────────────┐
                         │                                 │
                         ▼                                 ▼
               Private Application Subnet       Private Application Subnet
                   Availability Zone 1               Availability Zone 2
                         │                                 │
                         ▼                                 ▼
                  EC2 Application                     EC2 Application
                    Instances                           Instances
                         └──────── Auto Scaling Group ─────┘
                                          │
                                          ▼
                                Private Database Layer
                         ┌────────────────┴────────────────┐
                         │                                 │
                         ▼                                 ▼
                  RDS Primary Database              RDS Standby Database
                   Availability Zone 1               Availability Zone 2
                                          │
                                          ▼
                                 Automated Backups
                                          │
                                          ▼
                                 Amazon CloudWatch
                                          │
                                          ▼
                                      Amazon SNS
                                          │
                                          ▼
                                  Operations Alerts
```

---

## Architecture Layers

### Public Layer

The public layer receives traffic from internet users.

It contains:

* Internet Gateway
* Public route tables
* Public subnets across two Availability Zones
* NAT Gateways
* Application Load Balancer

Only the Application Load Balancer and NAT Gateways are deployed in public subnets.

### Application Layer

The application layer processes requests received from the Application Load Balancer.

It contains:

* Private application subnets
* EC2 Launch Template
* Auto Scaling Group
* EC2 application instances
* IAM instance profile
* Encrypted EBS root volumes

Application instances do not receive public IPv4 addresses.

### Database Layer

The database layer stores application data.

It contains:

* Isolated private database subnets
* DB subnet group
* Amazon RDS
* Multi-AZ database deployment
* Encrypted database storage
* Automated backups
* Database security group

The database is not publicly accessible.

---

## AWS Services Used

| AWS Service                 | Purpose                                                |
| --------------------------- | ------------------------------------------------------ |
| Amazon VPC                  | Provides an isolated virtual network                   |
| Public Subnets              | Host the ALB and NAT Gateways                          |
| Private Application Subnets | Host EC2 application instances                         |
| Private Database Subnets    | Host the RDS database                                  |
| Internet Gateway            | Provides internet access to public resources           |
| NAT Gateway                 | Provides outbound internet access to private instances |
| Elastic IP                  | Provides static public IP addresses for NAT Gateways   |
| Route Tables                | Control public and private network routing             |
| Security Groups             | Control resource-level network access                  |
| Application Load Balancer   | Distributes incoming application traffic               |
| Target Group                | Registers and monitors application instances           |
| EC2 Launch Template         | Defines EC2 instance configuration                     |
| EC2 Auto Scaling            | Maintains and scales application instances             |
| Amazon RDS                  | Provides a managed relational database                 |
| AWS IAM                     | Provides roles and least-privilege permissions         |
| Amazon S3                   | Stores Terraform state and application data            |
| Amazon DynamoDB             | Provides Terraform state locking when required         |
| AWS KMS                     | Provides encryption key management                     |
| Amazon CloudWatch           | Collects metrics, logs, dashboards, and alarms         |
| Amazon SNS                  | Delivers operational notifications                     |
| Amazon Route 53             | Manages DNS records                                    |
| AWS Certificate Manager     | Manages TLS certificates                               |

---

## Terraform Concepts Demonstrated

* Infrastructure as Code
* Terraform providers
* Provider version constraints
* Resource dependencies
* Input variables
* Output values
* Local values
* Data sources
* Reusable modules
* Remote state
* State locking
* Environment-specific configuration
* `for_each`
* `count`
* Conditional expressions
* Dynamic blocks
* Lifecycle rules
* Sensitive variables
* Variable validation
* Resource tagging
* Explicit and implicit dependencies

---

## High Availability

The infrastructure improves availability by:

* Deploying resources across two Availability Zones.
* Running EC2 instances through an Auto Scaling Group.
* Registering instances with an Application Load Balancer.
* Performing continuous target health checks.
* Automatically replacing unhealthy EC2 instances.
* Using multiple public and private subnets.
* Supporting an RDS Multi-AZ deployment.
* Avoiding dependency on a single application instance.

---

## Scalability

The application layer supports horizontal scaling through:

* EC2 Launch Templates
* Auto Scaling Groups
* Minimum, maximum, and desired instance capacity
* Target-tracking scaling policies
* CloudWatch metrics
* Application Load Balancer traffic distribution

When application demand increases, the Auto Scaling Group can launch additional EC2 instances. When demand decreases, unnecessary instances can be terminated to optimize cost.

---

## Security Design

The project follows a layered security model.

### Network Security

* Application instances run in private subnets.
* Database instances run in isolated private subnets.
* Application instances do not receive public IP addresses.
* The database is not publicly accessible.
* Public traffic reaches only the Application Load Balancer.
* Private instances use NAT Gateways for controlled outbound access.

### Security Group Flow

```text
Internet
   │
   │ HTTP/HTTPS
   ▼
ALB Security Group
   │
   │ Application Port
   ▼
Application Security Group
   │
   │ Database Port
   ▼
Database Security Group
```

The database security group accepts connections only from the application security group.

### Identity and Access Management

* EC2 instances use IAM roles instead of static access keys.
* IAM permissions follow the principle of least privilege.
* Terraform state access is restricted.
* Sensitive credentials are not committed to Git.
* AWS credentials are not hardcoded in Terraform files.

### Encryption

* RDS storage encryption is enabled.
* EBS encryption is enabled.
* S3 state encryption is enabled.
* TLS certificates are managed through AWS Certificate Manager.
* Sensitive Terraform outputs are marked as sensitive.

---

## Remote State Management

Terraform state is stored remotely to support collaboration and recovery.

```text
Terraform Client
       │
       ▼
Amazon S3
terraform.tfstate
       │
       ├── Encryption
       ├── Versioning
       └── Restricted IAM Access
       
State Coordination
       │
       ▼
State Locking Mechanism
```

The remote-state configuration provides:

* Centralized state storage
* State encryption
* State versioning
* Team collaboration
* Recovery from previous versions
* Protection against simultaneous changes

The state infrastructure must be created before initializing the main production infrastructure.

---

## Environment Separation

The project supports three isolated environments:

```text
environments/
├── dev/
├── staging/
└── production/
```

Each environment contains its own:

* Backend configuration
* Provider configuration
* Variable values
* Terraform state
* Resource naming
* Capacity settings
* Database settings
* Monitoring configuration

This prevents development changes from affecting staging or production infrastructure.

---

## Project Structure

```text
06-Production-Project/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
│
├── environments/
│   ├── dev/
│   │   ├── backend.hcl
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   ├── variables.tf
│   │   └── versions.tf
│   │
│   ├── staging/
│   │   ├── backend.hcl
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   ├── variables.tf
│   │   └── versions.tf
│   │
│   └── production/
│       ├── backend.hcl
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars
│       ├── variables.tf
│       └── versions.tf
│
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── security/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── load-balancer/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── compute/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── user-data.sh
│   │   └── variables.tf
│   │
│   ├── database/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── storage/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── monitoring/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── dns/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── diagrams/
│   └── architecture.drawio
│
├── docs/
│   ├── ARCHITECTURE.md
│   ├── DEPLOYMENT.md
│   ├── SECURITY.md
│   └── TROUBLESHOOTING.md
│
└── screenshots/
    └── README.md
```

---

## Module Responsibilities

| Module          | Responsibility                                            |
| --------------- | --------------------------------------------------------- |
| `networking`    | VPC, subnets, gateways, route tables, and network flow    |
| `security`      | ALB, application, and database security groups            |
| `iam`           | EC2 IAM role, policies, and instance profile              |
| `load-balancer` | ALB, target group, listeners, and health checks           |
| `compute`       | Launch Template, Auto Scaling Group, and scaling policies |
| `database`      | DB subnet group, parameter group, and RDS instance        |
| `storage`       | Secure S3 buckets and storage policies                    |
| `monitoring`    | CloudWatch logs, alarms, dashboard, and SNS               |
| `dns`           | Route 53 records and ACM integration                      |

---

## Naming Convention

Resources use a consistent naming convention:

```text
<project>-<environment>-<resource>
```

Examples:

```text
terraform-platform-dev-vpc
terraform-platform-staging-alb
terraform-platform-production-rds
```

---

## Resource Tagging

All supported resources receive standard tags.

```hcl
Project     = "terraform-production-platform"
Environment = "dev"
ManagedBy   = "Terraform"
Owner       = "Cloud-DevOps"
```

Additional resource-specific tags are applied where required.

---

## Prerequisites

Install and configure the following tools:

* Terraform
* AWS CLI
* Git
* An AWS account
* AWS credentials with the required permissions

Verify Terraform:

```bash
terraform version
```

Verify AWS CLI:

```bash
aws --version
```

Verify the authenticated AWS identity:

```bash
aws sts get-caller-identity
```

---

## Deployment Workflow

### 1. Clone the Repository

```bash
git clone https://github.com/arulkumar27/Terraform.git
cd Terraform/06-Production-Project
```

### 2. Create the Remote-State Infrastructure

```bash
cd bootstrap
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

### 3. Initialize the Development Environment

```bash
cd ../environments/dev
terraform init -backend-config=backend.hcl
```

### 4. Format and Validate the Configuration

```bash
terraform fmt -recursive
terraform validate
```

### 5. Create the Execution Plan

```bash
terraform plan -var-file=terraform.tfvars -out=tfplan
```

### 6. Review and Apply the Plan

```bash
terraform apply tfplan
```

### 7. Display Terraform Outputs

```bash
terraform output
```

---

## Staging Deployment

```bash
cd environments/staging
terraform init -backend-config=backend.hcl
terraform fmt -check
terraform validate
terraform plan -var-file=terraform.tfvars -out=tfplan
terraform apply tfplan
```

---

## Production Deployment

Production changes should be reviewed before deployment.

```bash
cd environments/production
terraform init -backend-config=backend.hcl
terraform fmt -check
terraform validate
terraform plan -var-file=terraform.tfvars -out=tfplan
terraform show tfplan
terraform apply tfplan
```

---

## Validation

After deployment, validate the infrastructure using the following checks.

### Terraform State

```bash
terraform state list
```

### Terraform Outputs

```bash
terraform output
```

### Load Balancer

Open the load balancer DNS output in a browser.

```bash
terraform output -raw load_balancer_dns_name
```

### Auto Scaling Group

Confirm that the desired number of EC2 instances is running and registered as healthy in the target group.

### Application Health

The Application Load Balancer health-check endpoint is:

```text
/health
```

Expected response:

```text
healthy
```

### Database

Confirm that:

* The database is deployed in private database subnets.
* Public accessibility is disabled.
* The database security group accepts connections only from the application security group.
* Storage encryption is enabled.
* Automated backups are configured.

### Monitoring

Confirm that:

* CloudWatch alarms are created.
* The CloudWatch dashboard is available.
* The SNS topic is created.
* Application log groups have retention configured.

---

## Monitoring and Alerting

The monitoring module configures observability for the infrastructure.

Monitored components include:

* EC2 CPU utilization
* EC2 instance health
* Auto Scaling activity
* ALB request count
* ALB response time
* ALB unhealthy host count
* ALB HTTP 5XX errors
* RDS CPU utilization
* RDS storage availability
* RDS database connections

CloudWatch alarms publish notifications to Amazon SNS.

```text
AWS Resource
     │
     ▼
CloudWatch Metric
     │
     ▼
CloudWatch Alarm
     │
     ▼
Amazon SNS
     │
     ▼
Operations Notification
```

---

## Auto Scaling Behaviour

The Auto Scaling Group maintains application availability through:

* Minimum capacity
* Desired capacity
* Maximum capacity
* EC2 health checks
* ELB target health checks
* Instance replacement
* Target-tracking scaling policy

Scaling example:

```text
Average CPU above target
          │
          ▼
Auto Scaling launches instances
          │
          ▼
Instances pass health checks
          │
          ▼
ALB begins routing traffic
```

---

## Failure Handling

### EC2 Instance Failure

If an EC2 instance becomes unhealthy:

1. The target group marks it unhealthy.
2. The ALB stops routing traffic to it.
3. The Auto Scaling Group terminates the unhealthy instance.
4. A replacement instance is launched.
5. The replacement instance completes its health check.
6. The ALB begins routing traffic to it.

### Availability Zone Failure

Application instances are distributed across multiple Availability Zones. The ALB continues routing traffic to healthy instances in the remaining Availability Zone.

### Database Failure

When RDS Multi-AZ is enabled, AWS can fail over to the standby database instance without requiring the application to use a new database endpoint.

### Terraform State Recovery

S3 versioning provides previous state versions that can be used during state recovery.

---

## Cost Considerations

This project uses production-oriented AWS services that may generate charges.

Potential cost-generating resources include:

* NAT Gateways
* Application Load Balancer
* EC2 instances
* Amazon RDS
* Route 53 hosted zones
* CloudWatch logs
* CloudWatch alarms
* AWS KMS
* Elastic IP addresses
* Data transfer

Development settings use smaller resource sizes where possible. Production settings prioritize availability and reliability.

Always review the Terraform execution plan and AWS Pricing Calculator before deploying production infrastructure.

---

## Cleanup

Destroy environment resources before destroying remote-state infrastructure.

### Destroy Development

```bash
cd environments/dev
terraform plan -destroy -var-file=terraform.tfvars -out=destroy.tfplan
terraform apply destroy.tfplan
```

### Destroy Staging

```bash
cd environments/staging
terraform plan -destroy -var-file=terraform.tfvars -out=destroy.tfplan
terraform apply destroy.tfplan
```

### Destroy Production

```bash
cd environments/production
terraform plan -destroy -var-file=terraform.tfvars -out=destroy.tfplan
terraform show destroy.tfplan
terraform apply destroy.tfplan
```

### Destroy Remote-State Infrastructure

Destroy the bootstrap resources only after all environment resources have been removed and the required state backups have been retained.

```bash
cd bootstrap
terraform destroy
```

---

## Important Safety Notes

* Never commit AWS credentials.
* Never commit private keys.
* Never commit `.tfstate` files.
* Never commit saved plan files.
* Never store production passwords directly in Terraform code.
* Review every production plan before applying it.
* Do not destroy the backend while environment state files are still required.
* Do not expose database ports to `0.0.0.0/0`.
* Do not assign public IP addresses to application or database resources.
* Enable deletion protection for critical production resources.
* Maintain separate state files for each environment.

---

## Troubleshooting Commands

Initialize or upgrade providers:

```bash
terraform init -upgrade
```

Format the entire project:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Review the current state:

```bash
terraform state list
```

Inspect a resource:

```bash
terraform state show RESOURCE_ADDRESS
```

Refresh and compare infrastructure:

```bash
terraform plan -refresh-only
```

Show a saved plan:

```bash
terraform show tfplan
```

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

Enable Terraform logging:

```bash
export TF_LOG=INFO
terraform plan
```

For Windows PowerShell:

```powershell
$env:TF_LOG="INFO"
terraform plan
```

Disable Terraform logging in Windows PowerShell:

```powershell
Remove-Item Env:TF_LOG
```

---

## Production Best Practices Demonstrated

* Modular Terraform code
* Multi-environment architecture
* Remote and encrypted Terraform state
* State locking
* Provider version constraints
* Multi-AZ network design
* Private application instances
* Private database deployment
* Security-group referencing
* IAM roles instead of static access keys
* Encrypted EBS and RDS storage
* Automated database backups
* Auto Scaling and health checks
* CloudWatch monitoring
* SNS notifications
* Standard resource naming
* Consistent resource tagging
* Separate deployment and destruction plans

---

## CI/CD Workflow

The project can be integrated with Jenkins, GitHub Actions, GitLab CI, or another CI/CD platform.

Recommended workflow:

```text
Pull Request
     │
     ▼
terraform fmt -check
     │
     ▼
terraform init
     │
     ▼
terraform validate
     │
     ▼
terraform plan
     │
     ▼
Manual Approval
     │
     ▼
terraform apply
```

Production deployments should include a mandatory approval stage.

---

## Future Enhancements

The architecture can be extended with:

* AWS WAF
* Amazon CloudFront
* AWS Secrets Manager
* AWS Systems Manager Session Manager
* VPC endpoints
* AWS Config
* AWS CloudTrail
* GuardDuty
* Centralized log archival
* Cross-region disaster recovery
* RDS read replicas
* AWS Backup
* Blue-green deployment
* Automated policy validation
* Terraform security scanning
* CI/CD deployment approvals

---

## Learning Outcomes

This project demonstrates practical experience with:

* Designing production-oriented AWS infrastructure.
* Implementing a three-tier architecture.
* Writing reusable Terraform modules.
* Managing multiple Terraform environments.
* Configuring remote Terraform state.
* Designing public and private network layers.
* Implementing load balancing and Auto Scaling.
* Securing communication between application layers.
* Deploying a private managed database.
* Implementing monitoring and operational alerting.
* Troubleshooting Terraform and AWS infrastructure.
* Applying Infrastructure as Code best practices.

---

## Interview Explanation

I developed a production-oriented three-tier AWS architecture using Terraform. I divided the configuration into reusable modules for networking, security, IAM, load balancing, compute, database, storage, monitoring, and DNS.

The infrastructure uses public subnets for the Application Load Balancer and NAT Gateways, private subnets for EC2 application instances, and isolated database subnets for Amazon RDS. EC2 instances are managed by an Auto Scaling Group and distributed across multiple Availability Zones.

The Application Load Balancer performs health checks and distributes traffic only to healthy instances. The database is private, encrypted, backed up, and protected using a security group that accepts traffic only from the application layer.

Terraform state is stored remotely with encryption and versioning. Development, staging, and production use separate state and configuration files. CloudWatch monitors the infrastructure, while SNS provides operational notifications.

This project demonstrates Infrastructure as Code, modular design, high availability, scalability, security, environment isolation, remote state management, and monitoring.

---

## License

This project is licensed under the MIT License.

---

## Author

**Arul Kumar**

Cloud and DevOps Engineer

GitHub: [arulkumar27](https://github.com/arulkumar27)

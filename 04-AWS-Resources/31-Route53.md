# Amazon Route 53

## Overview

Amazon Route 53 is AWS's highly available and scalable Domain Name System (DNS) web service. It translates human-readable domain names into IP addresses and intelligently routes users to AWS resources such as EC2 instances, Load Balancers, CloudFront distributions, S3 static websites, and API Gateway endpoints.

Terraform enables Route 53 resources to be managed as Infrastructure as Code (IaC), making DNS management automated, version-controlled, and repeatable.

---

# Why We Use Route 53

- Register domain names
- Manage DNS records
- Route traffic to AWS resources
- High Availability
- Health Checks
- Global Traffic Routing
- Disaster Recovery
- Failover
- Latency Optimization
- Multi-Region Routing

---

# Real-Time Use Case

A company owns the domain

```
www.company.com
```

Application Architecture

- CloudFront serves static content.
- ALB handles application traffic.
- EC2 hosts backend services.
- RDS stores application data.

Route 53 directs users to the nearest healthy AWS endpoint.

Terraform provisions the hosted zone, DNS records, health checks, and routing policies automatically.

---

# How Route 53 Works

```
           User

             │

     www.company.com

             │

             ▼

        Amazon Route 53

             │

             ▼

      Application Load Balancer

             │

     ┌───────┴────────┐

     ▼                ▼

   EC2-1            EC2-2
```

---

# Hosted Zone

A Hosted Zone stores DNS records for a domain.

Types

## Public Hosted Zone

Accessible from the internet.

Examples

```
company.com

example.com
```

---

## Private Hosted Zone

Accessible only inside a VPC.

Used for

- Internal Applications
- Private APIs
- Internal Databases

Terraform

```hcl
resource "aws_route53_zone" "main" {

  name = "company.com"

}
```

---

# DNS Records

DNS records map domain names to AWS resources.

---

## A Record

Maps a domain to an IPv4 address.

Example

```
www.company.com

↓

13.235.xxx.xxx
```

Terraform

```hcl
type = "A"
```

---

## AAAA Record

Maps a domain to an IPv6 address.

Terraform

```hcl
type = "AAAA"
```

---

## CNAME Record

Maps one domain to another domain.

Example

```
blog.company.com

↓

company.wordpress.com
```

Cannot be used at the root domain.

---

## Alias Record

AWS-specific DNS record.

Can point directly to

- Application Load Balancer
- Network Load Balancer
- CloudFront
- API Gateway
- S3 Website
- Global Accelerator

Advantages

- No additional DNS lookup
- No Route 53 query charges for AWS targets
- Supports root domain

Example

```
company.com

↓

Application Load Balancer
```

---

## MX Record

Mail Exchange Record.

Used for email services.

Example

```
company.com

↓

Google Workspace

↓

Microsoft 365
```

---

## TXT Record

Stores text information.

Uses

- Domain Verification
- SPF
- DKIM
- DMARC

Example

```
Google Verification

Amazon SES

SSL Validation
```

---

# Routing Policies

Route 53 supports intelligent traffic routing.

---

## Simple Routing

Routes traffic to one resource.

```
User

↓

One EC2
```

---

## Weighted Routing

Distributes traffic using percentages.

Example

```
80%

↓

Server A

20%

↓

Server B
```

Useful for

- Blue/Green Deployment
- Canary Releases

---

## Latency Routing

Routes users to the AWS Region with the lowest latency.

Example

```
India

↓

Mumbai Region
```

```
Europe

↓

Frankfurt Region
```

---

## Failover Routing

Used for Disaster Recovery.

```
Primary ALB

↓

Healthy

↓

Serve Traffic
```

If unhealthy

```
Secondary ALB

↓

Serve Traffic
```

---

## Geolocation Routing

Routes users based on geographic location.

Example

```
India

↓

Indian Website
```

```
USA

↓

US Website
```

---

## Geoproximity Routing

Routes traffic based on user location and AWS Region.

Requires

```
Route 53 Traffic Flow
```

---

## Multivalue Answer Routing

Returns multiple healthy IP addresses.

Improves availability.

---

# Health Checks

Route 53 continuously checks endpoint health.

Example

```
HTTP

↓

200 OK

↓

Healthy
```

If the endpoint fails,

Traffic is automatically redirected.

Terraform

```hcl
resource "aws_route53_health_check" "main" {

  fqdn = "company.com"

  port = 443

  type = "HTTPS"

}
```

---

# Terraform Resources

| Resource | Purpose |
|----------|----------|
| aws_route53_zone | Hosted Zone |
| aws_route53_record | DNS Record |
| aws_route53_health_check | Health Monitoring |

---

# Complete Example

```hcl
resource "aws_route53_zone" "main" {

  name = "company.com"

}

resource "aws_route53_record" "www" {

  zone_id = aws_route53_zone.main.zone_id

  name = "www"

  type = "A"

  alias {

    name = aws_lb.alb.dns_name

    zone_id = aws_lb.alb.zone_id

    evaluate_target_health = true

  }

}
```

---

# Real Project Example

Architecture

```
                   User
                     │
             www.company.com
                     │
                     ▼
               Amazon Route 53
                     │
                     ▼
                CloudFront CDN
                     │
                     ▼
          Application Load Balancer
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
       EC2-1      EC2-2      EC2-3
                     │
                     ▼
                 Amazon RDS
```

Features

- Global DNS
- High Availability
- Health Checks
- Failover
- SSL via ACM
- CloudFront Integration

---

# Best Practices

- Use Alias Records for AWS resources.
- Enable Health Checks for critical applications.
- Use Failover Routing for Disaster Recovery.
- Configure low TTL values during migrations.
- Use Private Hosted Zones for internal services.
- Protect domain registration with MFA.
- Use Weighted Routing for Blue/Green deployments.
- Regularly review DNS records.

---

# Common Mistakes

- Using CNAME for the root domain.
- Forgetting Health Checks.
- Incorrect TTL values.
- Deleting Hosted Zones accidentally.
- Misconfigured Alias records.
- Not validating ACM certificates correctly.

---

# Common Interview Questions

### What is Amazon Route 53?

Amazon Route 53 is AWS's scalable DNS service that routes user requests to AWS resources based on DNS records and routing policies.

---

### What is a Hosted Zone?

A Hosted Zone is a container that stores DNS records for a domain.

---

### Difference between Public and Private Hosted Zones?

| Public Hosted Zone | Private Hosted Zone |
|--------------------|---------------------|
| Internet Accessible | VPC Only |
| Public Websites | Internal Applications |
| Public DNS Resolution | Private DNS Resolution |

---

### Difference between Alias Record and CNAME?

| Alias | CNAME |
|--------|--------|
| AWS Resource Support | Any Domain |
| Root Domain Supported | Root Domain Not Supported |
| No Extra DNS Lookup | Additional DNS Lookup |

---

### What are Route 53 Health Checks?

Health Checks continuously monitor endpoints and allow Route 53 to route traffic only to healthy resources.

---

### Which Terraform resource creates a DNS record?

```hcl
aws_route53_record
```

---

# Summary

Amazon Route 53 is AWS's highly available DNS service that provides domain registration, DNS management, health checks, and intelligent traffic routing. Terraform automates Route 53 infrastructure by provisioning hosted zones, DNS records, and routing policies, enabling reliable, scalable, and production-ready domain management.

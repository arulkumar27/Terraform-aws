# Resources

Resources are the infrastructure components managed by Terraform.

Examples:
- EC2 Instance
- S3 Bucket
- Security Group
- VPC

## Example

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

## Resource Syntax

```hcl
resource "<provider>_<type>" "<name>" {
}
```

## Interview Question

Q. What is a Resource?

A. A Resource is any infrastructure object that Terraform creates and manages.
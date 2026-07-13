# Data Sources

Data Sources fetch information about existing resources.

## Example

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true
}
```

## Use Cases

- Existing VPC
- Existing AMI
- Existing Security Group

## Difference

Resource → Creates infrastructure

Data Source → Reads existing infrastructure

## Interview Question

Q. What is a Data Source?

A. A Data Source retrieves information about existing resources without creating them.
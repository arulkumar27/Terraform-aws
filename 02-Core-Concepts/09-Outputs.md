# Outputs

Outputs display useful information after Terraform deployment.

## Example

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

## Use Cases

- Display EC2 ID
- Display Public IP
- Display Bucket Name

## Command

```bash
terraform output
```

## Interview Question

Q. What are Outputs?

A. Outputs display information about created resources after deployment.
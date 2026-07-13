# Expressions

Expressions are used to calculate or generate values.

## Example

```hcl
instance_count = 2 + 3
```

## Conditional Expression

```hcl
instance_type = var.env == "prod" ? "t3.medium" : "t2.micro"
```

## Benefits

- Dynamic configurations
- Flexible infrastructure

## Interview Question

Q. What are Expressions?

A. Expressions are used to compute values dynamically in Terraform.
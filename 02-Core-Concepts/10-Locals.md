# Locals

Locals store reusable values within a Terraform configuration.

## Example

```hcl
locals {
  environment = "dev"
}
```

## Usage

```hcl
tags = {
  Name = local.environment
}
```

## Benefits

- Avoid repetition
- Improve readability
- Easier maintenance

## Interview Question

Q. What is the difference between Variables and Locals?

A. Variables accept external input, whereas Locals are defined and used within the configuration.
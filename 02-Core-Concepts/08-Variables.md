# Variables

Variables make Terraform configurations reusable and flexible.

## Define Variable

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

## Use Variable

```hcl
instance_type = var.instance_type
```

## Benefits

- Reusable code
- Easy customization
- Better maintenance

## Interview Question

Q. Why use Variables?

A. Variables help avoid hardcoding values and make configurations reusable.
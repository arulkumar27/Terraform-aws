# Meta Arguments

Meta Arguments control resource behavior.

Common Meta Arguments:

- count
- for_each
- depends_on
- lifecycle

## count Example

```hcl
resource "aws_instance" "web" {
  count = 2
}
```

## depends_on Example

```hcl
depends_on = [
  aws_security_group.web
]
```

## lifecycle Example

```hcl
lifecycle {
  prevent_destroy = true
}
```

## Interview Question

Q. What are Meta Arguments?

A. Meta Arguments are special settings that control how Terraform manages resources.
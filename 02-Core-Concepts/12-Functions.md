# Functions

Terraform provides built-in functions for data manipulation.

## Examples

### length()

```hcl
length(["a","b","c"])
```

### upper()

```hcl
upper("terraform")
```

### lower()

```hcl
lower("AWS")
```

### join()

```hcl
join("-", ["dev","server"])
```

## Benefits

- Simplifies code
- Reduces manual work

## Interview Question

Q. What are Terraform Functions?

A. Functions are built-in operations used to manipulate and transform data.
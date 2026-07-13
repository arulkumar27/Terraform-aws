# Lifecycle

Lifecycle rules control how Terraform creates, updates, or deletes resources.

## Common Lifecycle Rules

### prevent_destroy

```hcl
lifecycle {
  prevent_destroy = true
}
```

Prevents accidental deletion.

---

### create_before_destroy

```hcl
lifecycle {
  create_before_destroy = true
}
```

Creates the new resource before deleting the old one.

---

### ignore_changes

```hcl
lifecycle {
  ignore_changes = [
    tags
  ]
}
```

Ignores changes to specific attributes.

---

## Benefits

- Prevent accidental deletion
- Reduce downtime
- Control resource updates

---

## Interview Question

**Q. What is the Lifecycle block?**

**Answer:**
The Lifecycle block controls how Terraform creates, updates, and deletes resources.
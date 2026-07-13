# Provisioners

Provisioners execute scripts or commands after a resource is created.

Provisioners should be used only when necessary.

## Types

- local-exec
- remote-exec
- file

## local-exec Example

```hcl
provisioner "local-exec" {
  command = "echo EC2 Created"
}
```

## remote-exec Example

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo yum update -y"
  ]
}
```

## Use Cases

- Install software
- Run shell scripts
- Copy files
- Configure servers

---

## Interview Question

**Q. What is a Provisioner?**

**Answer:**
Provisioners execute commands or scripts on local or remote machines during resource creation.
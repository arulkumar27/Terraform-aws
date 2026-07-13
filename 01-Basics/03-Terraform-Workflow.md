# Terraform Workflow

Terraform follows a simple workflow.

## 1. Initialize

```bash
terraform init
```

Downloads required providers.

---

## 2. Validate

```bash
terraform validate
```

Checks configuration syntax.

---

## 3. Plan

```bash
terraform plan
```

Shows what Terraform is going to create.

---

## 4. Apply

```bash
terraform apply
```

Creates infrastructure.

---

## 5. Destroy

```bash
terraform destroy
```

Deletes all created resources.

---

## Workflow Diagram

```
Write Code
     │
     ▼
terraform init
     │
     ▼
terraform validate
     │
     ▼
terraform plan
     │
     ▼
terraform apply
     │
     ▼
Resources Created
```
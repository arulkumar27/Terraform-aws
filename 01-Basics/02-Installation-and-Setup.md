# Installation and Setup

## Step 1: Install Terraform

Download Terraform from:

https://developer.hashicorp.com/terraform/downloads

---

## Step 2: Verify Installation

```bash
terraform version
```

---

## Step 3: Install AWS CLI

```bash
aws --version
```

---

## Step 4: Configure AWS CLI

```bash
aws configure
```

Provide:

- AWS Access Key
- AWS Secret Key
- Region
- Output Format

---

## Verify Configuration

```bash
aws sts get-caller-identity
```

If your Account ID is displayed, Terraform is ready to use.
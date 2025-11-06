# Kubernetes on Proxmox using Terraform

This is a Terraform project to deploy a Kubernetes cluster on a proxmox node.

## Initialize project

To download all of the Terraform providers and modules you should first initialize the project.

```bash
terraform init
```

## Deploy

Run the `deploy.sh` script to deploy the cluster.

```bash
./deploy.sh
```

It will then ask for your proxmox root password.

## Destroy

Run the `destroy.sh` script to destroy the cluster.

```bash
./destroy.sh
```

It will then ask for your proxmox root password.
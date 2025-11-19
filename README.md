# Homalab Infrastructure

Automated deployment of a production-ready Kubernetes cluster on [Proxmox VE](https://proxmox.com/en/) using [Talos Linux](https://www.talos.dev/) and [Terraform](https://developer.hashicorp.com/terraform).

## Overview

This project deploys a highly-available Kubernetes cluster with (all of these parameters can be changed):
- **3 control plane nodes** (4 cores, 4GB RAM, 32GB disk each)
- **6 worker nodes** (4 cores, 4GB RAM, 100GB disk each)
- **Talos Linux** v1.11.3 as the operating system
- Automated cluster bootstrapping and configuration

## Prerequisites

- **Terraform**
- **Proxmox VE**

## Quick Start

### 1. Initialize Terraform

Download required providers and modules:

```bash
terraform init
```

### 2. Configure (Optional)

Edit [`deploy-talos.tf`](deploy-talos.tf) to customize and match your proxmox setup:
- Node count and names
- VM resources (CPU, RAM, disk)
- Network settings
- Talos version
- ...

Update [`provider.tf`](provider.tf) to match your Proxmox endpoint.

### 3. Deploy the Cluster

```bash
terraform apply -parallelism=2
```

You'll be prompted for your Proxmox root password. The deployment takes approximately 10-15 minutes.

After changing parameters or the amount of nodes you can just run the `deploy.sh` script again.

### 4. Access the Cluster

After deployment, retrieve your cluster credentials:

```bash
# Get kubeconfig
terraform output -raw kubeconfig > ~/.kube/config

# Get talosconfig
terraform output -raw talos_config > ~/.talos/config

# Verify cluster access
talosctl dashboard
kubectl get nodes
```

If nothing shows up the cluster is still configuring.

### 5. Access ArgoCD

Before logging into ArgoCD, retrieve the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Then port forward the ArgoCD server to access the web UI:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## Cleanup

To destroy the entire cluster:

```bash
terraform destroy -parallelism=2
```

You'll be prompted for your Proxmox root password. This will remove all VMs and associated resources.

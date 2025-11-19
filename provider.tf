terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.86.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.9.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.0.100:8006/"
  insecure = true
  username = "root@pam"
  password = var.proxmox_password
}

variable "proxmox_password" {
  type        = string
  sensitive   = true
  description = "Password for your proxmox node"
}

locals {
  kube_config = yamldecode(module.talos.kubeconfig)
}

provider "helm" {
  kubernetes = {
    host                   = local.kube_config.clusters[0].cluster.server
    
    client_certificate     = base64decode(local.kube_config.users[0].user.client-certificate-data)
    client_key             = base64decode(local.kube_config.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
  }
}
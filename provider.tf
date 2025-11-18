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
  password = var.proxmox_password
}

variable "proxmox_password" {
  type        = string
  sensitive   = true
  description = "Password for your proxmox node"
}
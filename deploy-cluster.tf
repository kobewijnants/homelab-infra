module "talos" {
    source  = "bbtechsys/talos/proxmox"
    version = "0.1.5"
    talos_cluster_name = "proxmox-k8s-cluster"
    talos_version = "1.11.3"
    control_nodes = {
        "test-control-0" = "alpha"
        "test-control-1" = "alpha"
        "test-control-2" = "alpha"
    }
    worker_nodes = {
        "test-worker-0" = "alpha"
        "test-worker-1" = "alpha"
        "test-worker-2" = "alpha"
        "test-worker-3" = "alpha"
        "test-worker-4" = "alpha"
        "test-worker-5" = "alpha"
    }

    proxmox_iso_datastore = "ISOTEMP"
    proxmox_image_datastore = "VDISK"

    proxmox_network_bridge = "vmbr0"
    proxmox_network_vlan_id = null
    proxmox_vm_type = "x86-64-v2-AES"

    proxmox_control_vm_cores = 4
    proxmox_control_vm_disk_size = 32
    proxmox_control_vm_memory = 4096

    proxmox_worker_vm_cores = 4
    proxmox_worker_vm_disk_size = 100
    proxmox_worker_vm_memory = 4096

    talos_arch = "amd64"
    talos_schematic_id = "ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515"

}

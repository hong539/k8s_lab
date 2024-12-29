terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url = "http://192.168.88.204:8006/api2/json"
  pm_tls_insecure = true
  pm_debug = true
}

resource "proxmox_vm_qemu" "k3s_server" {
  vmid        = 401
  name        = "k3s-server"
  target_node = "homelab-r5-4500-04"
  agent       = 1
  cores       = 2
  memory      = 4096
  boot        = "order=scsi0"
  clone       = "ubuntu24-cloud-init" # The name of the template
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml  
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=dhcp"
  skip_ipv6  = true
  ciuser     = "test"
  cipassword = "test!123"
  sshkeys    = file("~/.ssh/homelab@joe.pub")

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = "100G" 
        }
      }
    }
    sata {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      sata0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}

#Telmate/proxmox

## Troubleshooting/Tips/...etc

* Cloud-init:
  Snippets:
  [proxmox/wiki/Cloud-Init_FAQ](https://pve.proxmox.com/wiki/Cloud-Init_FAQ)
  [Terraform/Telmate/proxmox/Creating a Snippet](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud-init%2520getting%2520started#creating-a-snippet)
  [Example cloud-config file](https://cloudinit.readthedocs.io/en/latest/explanation/about-cloud-config.html#example-cloud-config-file)

* API 500 Error:
  Tips:just try [creating-the-connection-via-username-and-password](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-connection-via-username-and-password)

* From terrform:2024-12-29T12:34:58.388+0800 [ERROR] vertex "proxmox_vm_qemu.cloudinit-example" error: start failed: QEMU exited with code 1
╷
│ Error: start failed: QEMU exited with code 1
│ 
│   with proxmox_vm_qemu.cloudinit-example,
│   on main.tf line 17, in resource "proxmox_vm_qemu" "cloudinit-example":
│   17: resource "proxmox_vm_qemu" "cloudinit-example" {
│ 
╵
 From pve shell:
 qm start 107
Use of uninitialized value in split at /usr/share/perl5/PVE/QemuServer/Cloudinit.pm line 104.
generating cloud-init ISO
kvm: -device ide-cd,bus=ide.0,unit=1,drive=drive-ide1,id=ide1: Can't create IDE unit 1, bus supports only 1 units
start failed: QEMU exited with code 1

 Tips:change cloud-init ide1 to ide2 or another id#

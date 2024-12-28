#!/usr/bin/env bash
set -euxo pipefail

#Cloud-Init Image
#wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2

#create VM template on proxmox
qm create 9000 --name debian12-cloudinit --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --machine q35

qm set 9000 --scsi0 local-lvm:0,discard=on,ssd=1,format=qcow2,import-from=$(pwd)/debian-12-generic-amd64.qcow2

qm disk resize 9000 scsi0 8G

qm set 9000 --boot order=scsi0

qm set 9000 --cpu host --cores 2 --memory 2048

qm set 9000 --bios ovmf --efidisk0 local-lvm:1,format=raw,efitype=4m,pre-enrolled-keys=1

qm set 9000 --ide2 local-lvm:cloudinit

qm set 9000 --agent enabled=1

qm template 9000

#Creating a Snippet
#mkdir /var/lib/vz/snippets

#tee /var/lib/vz/snippets/qemu-guest-agent.yml <<EOF
#cloud-config
#runcmd:
#  - apt update
#  - apt install -y qemu-guest-agent
#  - systemctl start qemu-guest-agent
#EOF

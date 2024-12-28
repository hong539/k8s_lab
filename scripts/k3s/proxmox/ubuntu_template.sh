#!/usr/bin/env bash
set -euxo pipefail

#Cloud-Init Image
#wget https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img

#create VM template on proxmox
qm create 10000 --name ubuntu24-cloud-init --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --machine q35

qm set 10000 --scsi0 local-lvm:0,discard=on,ssd=1,format=qcow2,import-from=$(pwd)/ubuntu-24.04-server-cloudimg-amd64.img

qm disk resize 10000 scsi0 20G

qm set 10000 --boot order=scsi0

qm set 10000 --cpu host --cores 2 --memory 2048

qm set 10000 --bios ovmf --efidisk0 local-lvm:1,format=raw,efitype=4m,pre-enrolled-keys=1

qm set 10000 --ide2 local-lvm:cloudinit

qm set 10000 --agent enabled=1

qm template 10000

#Creating a Snippet
#mkdir /var/lib/vz/snippets

#tee /var/lib/vz/snippets/qemu-guest-agent.yml <<EOF
#cloud-config
#runcmd:
#  - apt update
#  - apt install -y qemu-guest-agent
#  - systemctl start qemu-guest-agent
#EOF

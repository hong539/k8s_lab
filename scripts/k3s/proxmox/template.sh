#!/usr/bin/env bash
set -euxo pipefail

#Cloud-Init Image
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2

qm create 9000 --name debian12-cloudinit

qm set 9000 --scsi0 local-lvm:0,import-from=/root/debian-12-genericcloud-amd64.qcow2

qm template 9000

#Creating a Snippet
mkdir /var/lib/vz/snippets

tee /var/lib/vz/snippets/qemu-guest-agent.yml <<EOF
#cloud-config
runcmd:
  - apt update
  - apt install -y qemu-guest-agent
  - systemctl start qemu-guest-agent
EOF
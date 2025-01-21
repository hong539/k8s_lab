#!/usr/bin/env bash
set -euxo pipefail

#method 01
for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    echo "VMID: $vmid"
    qm config $vmid
    echo "-----------------------------------"
done

#method 02
# for vmid in $(qm list | awk 'NR>1 {print $1}'); do
#     cpu=$(qm config $vmid | grep -i "^cores:" | awk '{print $2}')
#     mem=$(qm config $vmid | grep -i "^memory:" | awk '{print $2}')
#     disk=$(qm config $vmid | grep -i "^size:" | awk -F'=' '{sum+=$2} END {print sum}')
#     echo "VMID: $vmid, CPU: $cpu cores, Memory: $mem MB, Disk: ${disk:-N/A} GB"
# done

# for vmid in $(qm list | awk 'NR>1 {print $1}'); do
#     cpu=$(qm config $vmid | grep -i "^cores:" | awk '{print $2}')
#     mem=$(qm config $vmid | grep -i "^memory:" | awk '{print $2}')
#     disk=$(qm config $vmid | grep -Po 'size=\K[^\s,]+' | awk '{sum+=$1} END {print sum}')
#     echo "VMID: $vmid, CPU: $cpu cores, Memory: $mem MB, Disk: ${disk:-N/A} GB"
# done


for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    cpu=$(qm config $vmid | grep -i "^cores:" | awk '{print $2}')
    mem=$(qm config $vmid | grep -i "^memory:" | awk '{print $2}')
    #disk will not true for all VMs.
    disk=$(qm config $vmid | grep -Po '^scsi0:.*?size=\K[^\s,]+' | awk '
        /G$/ {sum += $1} 
        /M$/ {sum += $1 / 1024} 
        /K$/ {sum += $1 / (1024 * 1024)} 
        /T$/ {sum += $1 * 1024} 
        END {if (sum > 0) printf "%.2f", sum}')
    printf "VMID: %-5s | CPU: %-3s cores | Memory: %-6s MB | Disk: %-6s GB\n" "$vmid" "$cpu" "$mem" "${disk:-N/A}"
done

#method 03
curl -k -s -u root@pam:'<password>' "https://<proxmox_host>:8006/api2/json/nodes/<node_name>/qemu" | jq '.data[] | {vmid, name, maxcpu, maxmem, disk}'

curl -k -s -u root@pam:'!never20ff' "https://192.168.88.204:8006/api2/json/nodes/homelab-r5-4500-04/qemu" | jq '.data[] | {vmid, name, maxcpu, maxmem, disk}'

#method 04
for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    qm config $vmid > vm-$vmid.conf
done
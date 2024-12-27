#!/usr/bin/env bash
set -euxo pipefail

curl -v -k -X GET "https://<proxmox_ip>:8006/api2/json" -H "Authorization: PVEAPIToken=<username>@<realm>!<tokenid>=<token_secret>"
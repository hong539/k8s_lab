#!/usr/bin/env bash
set -euxo pipefail

#Creating the connection via username and password
export PM_USER="terraform-prov@pve"
export PM_PASS="password"

#Creating the connection via username and API token
export PM_API_TOKEN_ID="terraform-prov@pve!mytoken"
export PM_API_TOKEN_SECRET="afcd8f45-acc1-4d0f-bb12-a70b0777ec11"
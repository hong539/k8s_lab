#!/usr/bin/env bash
set -euxo pipefail

#Creating the connection via username and password
export PM_USER="terraform-prov@pve"
export PM_PASS="password"

#Creating the connection via username and API token
export PM_API_TOKEN_ID='<username>@<realm>!<tokenid>'
export PM_API_TOKEN_SECRET="<token_secret>"
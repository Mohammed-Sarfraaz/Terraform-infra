#!/usr/bin/env bash
set -euo pipefail

echo "Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

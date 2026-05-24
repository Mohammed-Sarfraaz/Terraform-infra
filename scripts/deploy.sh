#!/usr/bin/env bash
set -euo pipefail

echo "Initializing Terraform..."
terraform init

echo "Running validate..."
terraform validate

echo "Planning..."
terraform plan -out tfplan

echo "Applying..."
terraform apply -auto-approve tfplan

echo "Done. Use 'az aks get-credentials' to retrieve kubeconfig."

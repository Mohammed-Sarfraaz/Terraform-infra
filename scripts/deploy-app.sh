#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

acr_login_server=$(terraform output -raw acr_login_server)
resource_group=$(terraform output -raw resource_group_name)
aks_name=$(terraform output -raw aks_name)
image="$acr_login_server/simple-webapp:latest"
acr_name=${acr_login_server%%.*}

echo "Logging into ACR $acr_name..."
az acr login --name "$acr_name"

echo "Building Docker image $image..."
docker build -t "$image" app

echo "Pushing image to ACR..."
docker push "$image"

echo "Retrieving AKS credentials..."
az aks get-credentials --resource-group "$resource_group" --name "$aks_name"

echo "Applying Kubernetes manifests..."
kubectl apply -f kubernetes/namespace.yaml

tmpfile=$(mktemp)
sed "s|REPLACE_WITH_ACR/simple-webapp:latest|$image|g" kubernetes/deployment.yaml > "$tmpfile"
kubectl apply -f "$tmpfile"
rm -f "$tmpfile"
kubectl apply -f kubernetes/service.yaml

echo "Application deployment complete."

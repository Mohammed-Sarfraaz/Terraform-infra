Param()

$root = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location "$root\.."

$acrLoginServer = terraform output -raw acr_login_server
$resourceGroup = terraform output -raw resource_group_name
$aksName = terraform output -raw aks_name
$image = "$acrLoginServer/simple-webapp:latest"
$acrName = $acrLoginServer.Split('.')[0]

Write-Host "Logging into ACR $acrName..."
az acr login --name $acrName

Write-Host "Building Docker image $image..."
docker build -t $image .\app

Write-Host "Pushing Docker image..."
docker push $image

Write-Host "Retrieving AKS credentials..."
az aks get-credentials --resource-group $resourceGroup --name $aksName

Write-Host "Applying Kubernetes manifests..."
kubectl apply -f .\kubernetes\namespace.yaml

$deploymentContent = Get-Content -Path .\kubernetes\deployment.yaml -Raw
$deploymentContent = $deploymentContent -replace 'REPLACE_WITH_ACR/simple-webapp:latest', $image
$tempFile = [System.IO.Path]::Combine($env:TEMP, "simple-webapp-deployment.yaml")
Set-Content -Path $tempFile -Value $deploymentContent -Encoding utf8
kubectl apply -f $tempFile
Remove-Item -Path $tempFile -Force
kubectl apply -f .\kubernetes\service.yaml

Write-Host "Application deployment complete."

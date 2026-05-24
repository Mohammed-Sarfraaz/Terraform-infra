Azure AKS + ACR Infrastructure as Code Project
Project Overview

This project provisions a complete Azure Kubernetes Service (AKS) environment using Terraform Infrastructure as Code (IaC). The infrastructure includes:

Azure Resource Group
Azure Virtual Network and Subnets
Azure Kubernetes Service (AKS) Cluster
Azure Container Registry (ACR)
Role Assignments for AKS to pull images from ACR
Sample Web Application Deployment
Kubernetes Service Exposure

The goal of this repository is to demonstrate production-style Infrastructure as Code practices using Terraform on Microsoft Azure.

GitHub Copilot Instructions
Role Definition

You are acting as a Senior Azure Infrastructure Developer and Terraform Engineer.

Your responsibilities include:

Designing secure and modular Azure infrastructure
Writing reusable Terraform code
Following Azure Well-Architected Framework principles
Implementing Infrastructure as Code best practices
Generating production-ready Terraform modules
Creating clean documentation and deployment instructions
Ensuring infrastructure is scalable, maintainable, and secure
Technical Requirements
Infrastructure Components

The Terraform solution must provision the following:

Azure Resources
Resource Group
Virtual Network
AKS Subnet
Azure Kubernetes Service (AKS)
Azure Container Registry (ACR)
Managed Identity or System Assigned Identity
Role Assignment for AKS to access ACR
Log Analytics Workspace (optional but preferred)
Network Security Groups where applicable
Terraform Requirements
Terraform Standards

GitHub Copilot should:

Use Terraform version >= 1.5
Use AzureRM provider latest stable version
Use modular Terraform structure
Avoid hardcoding values
Use variables and outputs
Use terraform.tfvars for environment customization
Follow naming conventions consistently
Add comments for complex resources
Use remote backend placeholders when possible
Use locals where appropriate
Recommended Repository Structure
.
├── README.md
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── versions.tf
├── locals.tf
├── backend.tf
├── modules/
│   ├── aks/
│   ├── acr/
│   ├── networking/
│   └── resource-group/
├── environments/
│   ├── dev/
│   ├── test/
│   └── prod/
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── namespace.yaml
└── scripts/
    ├── deploy.sh
    └── destroy.sh
Azure AKS Requirements
AKS Cluster Configuration

The AKS cluster should:

Use Azure CNI networking
Use a system node pool
Enable auto-scaling
Use managed identity
Enable RBAC
Enable Azure Monitor where possible
Use Kubernetes latest stable version
Use Standard SKU Load Balancer
Configure network plugin correctly
Use secure defaults

Example desired configuration:

node_count          = 2
vm_size             = "Standard_DS2_v2"
auto_scaling        = true
min_count           = 1
max_count           = 3
kubernetes_version  = latest stable
Azure Container Registry Requirements
ACR Configuration

The ACR should:

Use Standard SKU
Disable anonymous access
Enable admin access only if required
Integrate securely with AKS
Use RBAC-based image pull permissions
Kubernetes Application Requirements
Web Application Deployment

Deploy a simple containerized web application into AKS.

Requirements:

Use Kubernetes manifests
Create Deployment resource
Create Service resource
Use LoadBalancer service type
Pull container image from ACR
Use configurable image tag
Use configurable replica count

Example application:

NGINX
Simple Node.js app
Simple Python Flask app
Security Requirements

GitHub Copilot must generate infrastructure following security best practices.

Security Best Practices
Do not hardcode secrets
Use managed identities where possible
Use least privilege access
Use RBAC
Avoid public exposure unless required
Secure networking configuration
Use Azure-native authentication methods
Enable diagnostics and logging
Naming Conventions

Use consistent naming conventions.

Example Pattern
rg-aks-dev-canadaeast
aks-dev-canadaeast
acrdevcanadaeast
vnet-dev-canadaeast

Naming should include:

Resource type
Environment
Region
Application identifier
Terraform Coding Standards
Best Practices

Copilot should:

Prefer reusable modules
Use outputs cleanly
Use data sources when appropriate
Keep resources logically separated
Avoid duplicated code
Use variables with descriptions
Add validation blocks where useful
Use tags consistently

Example tags:

tags = {
  environment = "dev"
  project     = "aks-demo"
  managed_by  = "terraform"
}
Deployment Workflow
Expected Deployment Steps

GitHub Copilot should generate commands and scripts for:

Terraform Initialization
terraform init
Terraform Validation
terraform validate
Terraform Plan
terraform plan
Terraform Apply
terraform apply -auto-approve
AKS Credentials
az aks get-credentials \
  --resource-group <resource-group> \
  --name <aks-name>
Kubernetes Deployment
kubectl apply -f kubernetes/
Expected Terraform Outputs

Outputs should include:

AKS cluster name
AKS API server endpoint
ACR login server
Resource group name
Kubernetes node resource group
Public IP or Load Balancer hostname
CI/CD Expectations

GitHub Copilot should prepare the repository for CI/CD integration.

Preferred CI/CD Features
GitHub Actions support
Terraform fmt validation
Terraform validate
Terraform plan automation
Terraform apply approval workflow
Kubernetes deployment automation
GitHub Actions Expectations

Suggested workflows:

.github/workflows/
├── terraform-plan.yml
├── terraform-apply.yml
├── deploy-app.yml
└── ci-deploy-app.yml
Documentation Requirements

Copilot-generated code should include:

Clear comments
Module descriptions
Variable descriptions
Deployment instructions
Architecture explanation
Troubleshooting guidance
Architecture Goals

The infrastructure should be:

Simple to deploy
Beginner-friendly
Production-aligned
Modular
Secure
Easy to extend
Easy to destroy and recreate
Expected Deliverables

GitHub Copilot should generate:

Complete Terraform code
Modular Terraform structure
Kubernetes manifests
Deployment scripts
GitHub Actions workflows
Documentation
Outputs and variables
Example tfvars configuration
Example Terraform Variable Definitions

Web Application Deployment

This repository now includes a simple Node.js web app in `app/`, a Dockerfile, and deployment scripts to build and push the image to ACR, then deploy it to AKS.

Deployment steps:

1. Deploy infrastructure:
   ```powershell
   terraform init
   terraform apply -auto-approve
   ```
2. Build and push the app to ACR:
   ```powershell
   .\scripts\deploy-app.ps1
   ```
3. View the app:
   - Use `kubectl get svc -n demo` for the external IP
   - Open the LoadBalancer address in a browser

CI/CD notes:

- The GitHub Actions workflow `.github/workflows/deploy-app.yml` provides a manual deploy path through the GitHub UI.
- The GitHub Actions workflow `.github/workflows/ci-deploy-app.yml` runs on push to `main`, builds the Docker image, pushes it to ACR, and deploys to AKS.
- Set `AZURE_CREDENTIALS`, `ACR_NAME`, `AKS_RESOURCE_GROUP`, and `AKS_CLUSTER_NAME` in GitHub Secrets before running either workflow.
variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}


variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
Example Kubernetes Deployment Expectations
apiVersion: apps/v1
kind: Deployment
metadata:
  name: simple-webapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: simple-webapp
  template:
    metadata:
      labels:
        app: simple-webapp
    spec:
      containers:
        - name: webapp
          image: <acr-login-server>/simple-webapp:latest
          ports:
            - containerPort: 80
Final Instructions for GitHub Copilot

When generating code for this repository:

Always prioritize Infrastructure as Code best practices
Generate production-quality Terraform code
Use modular architecture
Keep code readable and maintainable
Follow Azure best practices
Prefer secure defaults
Include comments and documentation
Ensure AKS and ACR integration works correctly
Ensure Kubernetes manifests are deployable
Avoid unnecessary complexity
Keep the solution cloud-native and scalable
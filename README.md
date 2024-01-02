# GKE Cluster Deployment using Terraform and GitHub Actions

This repository contains Terraform modules and files to install a Google Kubernetes Engine (GKE) cluster in Google Cloud Platform (GCP). The deployment process is automated using GitHub Actions.

## Prerequisites

Before running the deployment, ensure the following prerequisites are met:

1. **Google Cloud Project:**
   - Create a Google Cloud Project.
   - Make note of the Project ID.


2. **Run GCP Commands:**
   - Update `gcloud-commands.sh` file provided in the repo and update the require variables mentioned in the files and then Execute the `gcloud-commands.sh` commands in  in Google Cloud Shell or by a user with admin access and the `gcloud` CLI installed.


3. **Workload Identity Provider Secret:**
   - Create a secret in GitHub named `GCP_WORKLOAD_INDENTITY_PROVIDER` containing the Workload Identity Provider details.

4. **GCP Service Account Secret:**
   - Create a secret in GitHub named `GCP_SERVICE_ACCOUNT` containing the GCP service account key.

5. **Update GitHub Actions Workflow:**
   - Open `.github/workflows/terraform.yaml`.
   - Update the following variables in the `env` section:
     - `GKE_REGION`: GCP region for GKE cluster.
     - `GKE_CLUSTER_NAME`: Name of the GKE cluster.
     - `TKSTATE_BUCKET_NAME`: Name of the GCS bucket for Terraform state.

## GitHub Actions Workflow
The deployment is triggered by the GitHub Actions workflow defined in `.github/workflows/terraform.yaml`. This workflow performs the following steps:

1. Sets up the required environment variables.
2. Configures `gcloud` with the provided e Workload Identity Provider and service account.
3. Authenticates with Google Cloud using the provided Workload Identity Provider.
4. Initializes and applies the Terraform configuration.


### This repository only consist the code to deploy Kubernetes Cluster using Terraform, installation for NGINX INGRESS CONTROLLER and SAMPPLE NGINX APPLICATION code is stored in below mentioned repositories

- NGINX INGRESS CONTROLLER AND MONITORING TOOL (PROMETHEUS AND GRAFANA DEPLOYMENT CODE) - `https://github.com/rohitkamle/dlgkeadmin` 
- NGINX APPLICATION CODE - `https://github.com/rohitkamle/dlgkeadmin` 

This is another run
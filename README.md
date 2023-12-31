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


6. **Update hosts file to access grafana and nginx application using url**
    - To access grafana which is pointed to host : `grafana.dlgkedemo.com`  and `nginx.dlgkedemo.com` , local host file need to update with the ingress IP Address
    - For windows file location is `C:\Windows\System32\drivers\etc\hosts`  which can be open with notepad with Run As Administrator option
    - For MAC Book file location is `/etc/hosts` can be open using sudo nano `sudo nano /etc/hosts` or  `sudo vim /etc/hosts`


## GitHub Actions Workflow
The deployment is triggered by the GitHub Actions workflow defined in `.github/workflows/terraform.yaml`. This workflow performs the following steps:

1. Sets up the required environment variables.
2. Configures `gcloud` with the provided e Workload Identity Provider and service account.
3. Authenticates with Google Cloud using the provided Workload Identity Provider.
4. Initializes and applies the Terraform configuration.


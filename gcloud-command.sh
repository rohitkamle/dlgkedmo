#### UPDATE BELOW DETAILS

PROJECT_ID="fabled-era-408608"
SA_NAME="dlgkedemosatf"
WIF_POOL_NAME="dlwifpool"
WIF_POOL_DISPLAY_NAME="DL DEMO WIF POOL"
WIF_PROVIDER_NAME="dlwifprovider"
SA_DISPLAY_NAME="DL DEMO SERVICE ACCOUNT FOR GITHUB ACTION"
GITHUB_REPO="rohitkamle/dlgkedmo"
STORAGE_BUCKET_NAME="dlgkedemotfstatebucket"
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")


# CREATE SERVICE ACCOUNT
gcloud iam service-accounts create $SA_NAME --description="Service account for Terraform GCP deployment" --display-name="$SA_DISPLAY_NAME"

# ASSIGN PERSMISSIONS TO SERVICE ACCOUNT
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/compute.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/container.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/compute.networkAdmin" 
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/iam.serviceAccountAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/artifactregistry.admin"


# CREATED MANAGED IDENTITY POOL AND PROVIDER
gcloud iam workload-identity-pools create $WIF_POOL_NAME --project $PROJECT_ID --location "global" --display-name "$WIF_POOL_DISPLAY_NAME"

gcloud iam workload-identity-pools providers create-oidc $WIF_PROVIDER_NAME --project $PROJECT_ID --location="global" --workload-identity-pool=$WIF_POOL_NAME --display-name=$WIF_PROVIDER_NAME --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" --issuer-uri="https://token.actions.githubusercontent.com"


# GET PROJECT NUMBER

#THIS STEP IS IMPORTANT TO ASSIGNING WORKLOAD IDENTITY PROVIDER TO SERVICES ACCOUNT MAPPING AND GITHUB ACCOUNT DETAILS.
gcloud iam service-accounts add-iam-policy-binding "$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --project="$PROJECT_ID" --role="roles/iam.workloadIdentityUser" --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$WIF_POOL_NAME/attribute.repository/$GITHUB_REPO"



# Creat Bucker for storing Terraform State in the Project, need to enable billing account if not enabled..
gcloud storage buckets create gs://$STORAGE_BUCKET_NAME

#Enable Required APIs 
gcloud services enable iamcredentials.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com




GCP_WORKLOAD_IDENTITY_PROVIDER=$(gcloud iam workload-identity-pools providers describe $WIF_PROVIDER_NAME --project $PROJECT_ID --location="global" --workload-identity-pool=$WIF_POOL_NAME --format="value(name)" )
# Below command it get the Service Account name which needs to be added in Github secrets as GCP_SERVICE_ACCOUNT
GCP_SERVICE_ACCOUNT=$(gcloud iam service-accounts describe $SA_NAME@$PROJECT_ID.iam.gserviceaccount.com --project=$PROJECT_ID --format="value(email)")

#output: dlgkedemosatf@fabled-era-408608.iam.gserviceaccount.com

echo "GCP_WORKLOAD_IDENTITY_PROVIDER = $GCP_WORKLOAD_INDENTITY_PROVIDER"
echo "GCP_SERVICE_ACCOUNT = $GCP_SERVICE_ACCOUNT"





































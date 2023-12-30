PROJECT_ID="fabled-era-408608"
WIF_POOL_NAME="dlwifpool"
WIF_POOL_DISPLAY_NAME="DL DEMO WIF POOL"
WIF_PROVIDER_NAME="dlwifprovider"
SA_NAME="dlgkedemosatf"
SA_DISPLAY_NAME="DL DEMO SERVICE ACCOUNT FOR GITHUB ACTION"
GITHUB_REPO="rohitkamle/dlgkedmo"
STORAGE_BUCKET_NAME="dlgkedemotfstatebucket"

gcloud iam workload-identity-pools create $WIF_POOL_NAME --project $PROJECT_ID --location "global" --display-name "$WIF_POOL_DISPLAY_NAME"

gcloud iam workload-identity-pools providers create-oidc $WIF_PROVIDER_NAME --project $PROJECT_ID --location="global" --workload-identity-pool=$WIF_POOL_NAME --display-name=$WIF_PROVIDER_NAME --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" --issuer-uri="https://token.actions.githubusercontent.com"



gcloud iam service-accounts create $SA_NAME --description="Service account for Terraform GCP deployment" --display-name="$SA_DISPLAY_NAME"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/compute.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/container.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/iam.serviceAccountTokenCreator"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/storage.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" --role "roles/compute.networkAdmin" 

PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")

gcloud projects add-iam-policy-binding $PROJECT_ID --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$WIF_POOL_NAME/*" --role="roles/iam.workloadIdentityUser"
# Creat Bucker for storing Terraform State in the Project, need to enable billing account if not enabled..
gcloud storage buckets create gs://$STORAGE_BUCKET_NAME

#Enable "IAM Service Account Credentials API" 
gcloud services enable iamcredentials.googleapis.com

# Below command it get the Workload identity pool name which needs to be added in Github secrets as GCP_WORKLOAD_INDENTITY_PROVIDER
# EXAMPLE : projects/638663299784/locations/global/workloadIdentityPools/rk-gihub-wif-pool/providers/rk-gihub-wif-pool'

GCP_WORKLOAD_INDENTITY_PROVIDER=$(gcloud iam workload-identity-pools providers describe $WIF_PROVIDER_NAME --project $PROJECT_ID --location="global" --workload-identity-pool=$WIF_POOL_NAME --format="value(name)" )

# output: projects/717097444127/locations/global/workloadIdentityPools/dlwifpool/providers/dlwifprovider

# Below command it get the Service Account name which needs to be added in Github secrets as GCP_SERVICE_ACCOUNT
GCP_SERVICE_ACCOUNT=$(gcloud iam service-accounts describe $SA_NAME@$PROJECT_ID.iam.gserviceaccount.com --project=$PROJECT_ID --format="value(email)")

#output: dlgkedemosatf@dlgkedemo.iam.gserviceaccount.com

echo "GCP_WORKLOAD_INDENTITY_PROVIDER = $GCP_WORKLOAD_INDENTITY_PROVIDER"
echo "GCP_SERVICE_ACCOUNT = $GCP_SERVICE_ACCOUNT"






#!/bin/bash
set -a

PROJECT_ID=esl-efg
TERRAFORM_SERVICE_ACCOUNT_NAME=svc-terraform
STATE_FILE_BUCKET_NAME=${PROJECT_ID}-statefiles

svc_account_roles=( \
"roles/iam.serviceAccountTokenCreator" \
"roles/compute.networkAdmin" \
"roles/storage.objectViewer" \
"roles/compute.instanceAdmin"     \
"roles/compute.loadBalancerAdmin" \
"roles/compute.securityAdmin" \
"roles/artifactregistry.admin" \
"roles/iam.serviceAccountUser" \
"roles/secretmanager.admin" \
"roles/run.admin" \
"roles/vpcaccess.admin" \
"roles/servicemanagement.admin" \
"roles/storage.objectAdmin"
)
echo "Setting the project_id to $PROJECT_ID"
gcloud config set project $PROJECT_ID

echo "creating service account $TERRAFORM_SERVICE_ACCOUNT_NAME"
gcloud iam service-accounts create $TERRAFORM_SERVICE_ACCOUNT_NAME --description "This account is for terraform to use" --display-name "$TERRAFORM_SERVICE_ACCOUNT_NAME" 2> /dev/null

echo adding IAM policy bindings to the $TERRAFORM_SERVICE_ACCOUNT_NAME service account
for role in "${svc_account_roles[@]}"
do
  gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$TERRAFORM_SERVICE_ACCOUNT_NAME@${PROJECT_ID}.iam.gserviceaccount.com" --role="$role" > /dev/null
done

existing_keys=$(gcloud iam service-accounts keys list --iam-account="${TERRAFORM_SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" --format="value(name)")

echo "Deleting the following keys $existing_keys"

for key in $existing_keys
do
  gcloud iam service-accounts keys delete $key --iam-account="$TERRAFORM_SERVICE_ACCOUNT_NAME@${PROJECT_ID}.iam.gserviceaccount.com" --quiet
done

echo "Creating a new key for $TERRAFORM_SERVICE_ACCOUNT_NAME and storing it locally in $PWD/terraform-service-account.json"
gcloud iam service-accounts keys create "$PWD/terraform-service-account.json" --iam-account "$TERRAFORM_SERVICE_ACCOUNT_NAME@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud storage buckets create gs://$STATE_FILE_BUCKET_NAME
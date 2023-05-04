#!/bin/bash

PROJECT_ID=esl-efg
STATE_FILE_BUCKET_NAME=${PROJECT_ID}-statefiles
TERRAFORM_SERVICE_ACCOUNT_NAME=svc-terraform

echo "Setting the project_id to $PROJECT_ID"
gcloud config set project $PROJECT_ID

gcloud iam service-accounts delete "${TERRAFORM_SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud storage rm --recursive gs://$STATE_FILE_BUCKET_NAME

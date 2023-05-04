#!/bin/bash
PROJECT_ID=esl-efg

echo "Setting the project_id to $PROJECT_ID"
gcloud config set project $PROJECT_ID

APIS="compute.googleapis.com \
cloudresourcemanager.googleapis.com \
artifactregistry.googleapis.com \
secretmanager.googleapis.com \
run.googleapis.com \
vpcaccess.googleapis.com \
iamcredentials.googleapis.com"

echo Enabling $APIS
gcloud services enable "$APIS"
#!/bin/bash

PROJECT_ID=esl-efg
STATE_FILE_BUCKET_NAME=${PROJECT_ID}-statefiles

echo "Setting the project_id to $PROJECT_ID"
gcloud config set project $PROJECT_ID

gcloud storage buckets create gs://$STATE_FILE_BUCKET_NAME
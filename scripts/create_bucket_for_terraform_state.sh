#!/bin/bash

PROJECT_ID=esl-efg
STATE_FILE_BUCKET_NAME=${PROJECT_ID}-statefiles

gcloud storage buckets create gs://$STATE_FILE_BUCKET_NAME
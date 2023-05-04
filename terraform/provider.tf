# For provider login you need to export the following variable to GOOGLE_APPLICATION_CREDENTIALS=path/to/service-account-key.json
# If you use the scripts/create_terraform_service_account.sh then you can run GOOGLE_APPLICATION_CREDENTIALS=$PWD/terraform-service-account.json
# from project root.

terraform {
  backend "gcs" {
    bucket  = "esl-efg-statefiles"
    prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.63.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
}

provider "google-beta" {
  project = var.project_id
  region = var.region
}
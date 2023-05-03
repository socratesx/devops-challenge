terraform {
  backend "gcs" {
    bucket  = "esl-efg-statefiles"
    prefix  = "terraform/state"
#    credentials = "../terraform-service-account.json"
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
#  credentials = file("../terraform-service-account.json")
  region = var.region
}

provider "google-beta" {
  project = var.project_id
#  credentials = file("../terraform-service-account.json")
  region = var.region
}
/*
 * # Google Container Registry Module
 * This custom module is used to create a docker-type artifact registry, build and push a container to that registry.
*/

data "google_project" "current" {}

# We create the artifact registry
resource "google_artifact_registry_repository" "app_repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "${var.repository_id} is managed by terraform"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

# The following null_resource runs an inline script for building and pushing the docker container to the registry. It is
# triggered by changes in the registry_id or changes in the file_checksums in the application code directory.
resource "null_resource" "image_push" {
  triggers = {
    registry_id    = google_artifact_registry_repository.app_repo.id
    file_checksums = join(",", [for f in fileset(var.application_code, "**") : filemd5("${var.application_code}/${f}")])
  }
  provisioner "local-exec" {
    command = <<EOF
#!/bin/bash

IMAGE_REGISTRY=${var.region}-docker.pkg.dev/${data.google_project.current.project_id}/${var.repository_id}

export ACCESS_TOKEN=$(gcloud auth print-access-token)
echo "$ACCESS_TOKEN" | docker --config docker_config login -u oauth2accesstoken --password-stdin $IMAGE_REGISTRY

docker --config docker_config build -t $IMAGE_REGISTRY/${var.repository_id}:${var.app_version} ../

docker --config docker_config push $IMAGE_REGISTRY/${var.repository_id}:${var.app_version}

rm -rf docker_config
EOF
  }
}


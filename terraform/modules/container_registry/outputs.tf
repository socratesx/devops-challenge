output "container_image" {
  description = "The full url of the container image in the registry"
  value = "${var.region}-docker.pkg.dev/${data.google_project.current.project_id}/${var.repository_id}/${var.repository_id}:${var.app_version}"
}


variable "apis_to_enable" {
  description = "This variable contains all google apis required by this project"
  type = list(string)
  default = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com"
  ]
}

resource "google_project_service" "api" {
  for_each = toset(var.apis_to_enable)
  project = var.project_id
  service = each.key
  # The apis will not be disabled after destroying
  disable_on_destroy = false
}
# Required Inputs
variable "region" {
  type = string
  description = "The region to use for the artifact registry location"
}

variable "repository_id" {
  type = string
  description = "The last part of the repository name"
}

variable "app_version" {
  type = string
  description = "The application version/tag to push to the registry"
}

# Optional inputs
variable "application_code" {
  type = string
  description = "The application code path in this repository"
  default = "../test-app"
}
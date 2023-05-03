# Most of these outputs are known before since their values are included in the input vars. The reason that we declare
# them is for making implicit dependencies between the different module calls in this project.

output "application_subnet_name" {
  description = "The application subnet name"
  value = google_compute_subnetwork.application.name
}

output "connector_subnet_name" {
  description = "The VPC access connector, subnet name"
  value = google_compute_subnetwork.serverless_access.name
}

output "connector_id" {
  description = "The VCP access connector id"
  value = google_vpc_access_connector.connector.id
}

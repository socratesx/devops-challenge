output "endpoint" {
  description = "This output contains the service endpoint."
  value = google_cloud_run_v2_service.service.uri
}
/*
 * # Google Cloud Run Service Custom Module
 * This custom module can deploy a simple service in Google Cloud Run. It provides a simple output with the cloud run
 * service endpoint.
*/

resource "google_cloud_run_v2_service" "service" {
  name     = var.name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"
  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  template {
    # If the connector_id input is specified then enable vpc_access with through this VPC access connector
    dynamic "vpc_access" {
      for_each = var.connector_id == null ? [] : [1]
      content {
        connector = var.connector_id
        egress    = "ALL_TRAFFIC"
      }
    }

    # This variable defaults to null and if skipped it will use the default behavior. This variable can be part of a
    # ci/cd process using a compatible naming convention like a commit id or tag for create a meaningful association
    # with the application development.
    revision = var.revision == null ? null : "${var.name}-${var.revision}"

    scaling {
      min_instance_count = var.min_instance_count
      max_instance_count = max(var.max_instance_count, var.min_instance_count)
    }
    containers {
      image = var.image_url

      # The following block will populate dynamically the environment variables that are specified in the environment input
      dynamic "env" {
        for_each = var.environment
        content {
          name  = env.value.name
          value = env.value.value
          dynamic "value_source" {
            for_each = env.value.secret_id == null ? [] : [1]
            content {
              secret_key_ref {
                secret  = env.value.secret_id
                version = "latest"
              }
            }
          }
        }
      }
      ports {
        container_port = var.container_port
        name           = var.port_name
      }

      liveness_probe {
        initial_delay_seconds = 20
        dynamic "http_get" {
          for_each = var.liveness_probe.probe_type == "http_get" ? [1] : []
          content {
            path = lookup(var.liveness_probe, "path", "/")
          }
        }
        dynamic "grpc" {
          for_each = var.liveness_probe.probe_type == "grpc" ? [1] : []
          content {
            port = lookup(var.liveness_probe, "port", null)
          }
        }
      }
    }
  }
}




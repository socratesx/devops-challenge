# Required Inputs
variable "region" {
  type        = string
  description = "Region to run the container"
}

variable "name" {
  type        = string
  description = "The name of the cloud run service to run"
}

variable "image_url" {
  type        = string
  description = "The full url of the container image to use"
}

variable "container_port" {
  type        = number
  description = "The port where the application is running"
}

variable "port_name" {
  type        = string
  description = "The name of the container port"
  default     = "http1"
}

# Optional Inputs

variable "revision" {
  type        = string
  description = "The name of the revision"
  default     = null
}

variable "environment" {
  description = "A list of environment variable definitions to include in the container"
  default     = []
  type = list(object({
    name      = string           # The name of the env var
    value     = optional(string) # The value of the env var, plain text
    secret_id = optional(string) # The env var value can be sourced by a secret_id in secrets manager
  }))
}

variable "liveness_probe" {
  description = "Liveness probe configuration object. If skipped it will use grpc defaults."
  default = {
    probe_type = "grpc"
  }
  type = object({
    probe_type = string           # Can be http_get or grpc
    path       = optional(string) # used only when http_get is specified. defaults to "/"
    port       = optional(number) # used if grpc to specify the port to check. defaults to container_port
  })
}

variable "min_instance_count" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "max_instance_count" {
  description = "Maximum number of instances"
  type        = number
  default     = 4
}

variable "connector_id" {
  description = "The id of the vpc access connector. If skipped then the service is not deployed in a specific vpc"
  type        = string
  default     = null
}

variable "ingress" {
  description = "The ingress type for the cloud run service"
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"
}
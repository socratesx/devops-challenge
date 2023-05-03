# Required inputs
variable "network_name" {
  type        = string
  description = "The GCP network name to create"
}

variable "application_subnet_name" {
  type        = string
  description = "The name of the application subnet"
}

variable "region" {
  type        = string
  description = "The region to create the network"
}

variable "vpc_connector_subnet_name" {
  type        = string
  description = "The name of the vpc serverless connector subnet"
}

# Optional inputs
variable "application_subnet_cidr" {
  type        = string
  description = "The cidr range to assign to the application subnet"
  default     = "10.96.0.0/20"
}

variable "vpc_connector_subnet_cidr" {
  type        = string
  description = "The cidr range to assign to the vpc serverless connector subnet"
  default     = "10.8.0.0/28"
}






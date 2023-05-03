# Required Inputs

variable "region" {
  description = "The region to deploy the compute instance"
}

variable "subnetwork_name" {
  description = "The name of the subnetwork to deploy the instance"
}

variable "instance_name" {
  description = "The desired name to assign to the deployed instance"
}

variable "container_port" {
  description = "The port the running container listens to"
  type        = number
}

variable "container_image" {
  description = "The container image to run in the VM"
  type        = string
}

# Optional Inputs

variable "cos_image_name" {
  description = "The COS image to use. If not specified it uses the latest"
  default     = null #"cos-stable-77-12371-89-0"
}

variable "machine_type" {
  description = "The machine type of the compute instance"
  type        = string
  default     = "e2-micro"
}

variable "container_environment" {
  description = "A list of env vars to include in the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "container_volume_mounts" {
  description = "A list of volume mounts to include in the container declaration"
  type = list(object({
    mountPath = string
    name      = string
    readOnly  = bool
  }))
  default = []
}

variable "container_volumes" {
  description = " A list of volumes to attach in the container"
  type = list(object({
    name = string
    hostPath = optional(object({
      path = string
    }))
    memory = optional(object({
      medium = string
    }))
    gcePersistentDisk = optional(object({
      pdName = string
      fsType = string
    }))
    readOnly = bool
  }))
  default = []
}

variable "container_restart_policy" {
  description = "The container restart policy"
  type        = string
  default     = "always"
}



variable "project_id" {
  description = "The project ID to deploy resource into"
  type        = string
  default     = "esl-efg"
}

variable "region" {
  description = "The region to be used to deploy"
  type        = string
  default     = "europe-west3"
}

variable "app_version" {
  description = "This variable can be used to set the container tag during the build and push process"
  default     = "latest"
}
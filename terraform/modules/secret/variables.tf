# Required inputs

variable "secret_id" {
  type = string
  description = "The secret name"
}

# Optional inputs
variable "length" {
  type = number
  default = 16
  description = "The secret length"
}
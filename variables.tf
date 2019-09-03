variable "namespace" {
  description = "namespace of the resources"
  type        = "string"
  default     = "sns"
}

variable "tags" {
  description = "tags for resource"
  type        = "map"
  default     = {
    CreatedBy = "Terraform"
  }
}

variable "debug" {
  description   = "Whether capture success feedback"
  type          = "string"
  default       = "true"
}

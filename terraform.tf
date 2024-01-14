variable "project" {
  type        = string
  description = "gcp project id"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "resources region"
}

variable "credentials" {
  type        = string
  default     = ""
  description = "credentials location path"
}
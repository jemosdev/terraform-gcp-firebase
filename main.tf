
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.11.0"
    }
  }
}

locals {
  services = [
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com"
  ]
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.credentials == "" ? null : (var.credentials)
}

provider "google-beta" {
  project     = var.project
  region      = var.region
  credentials = var.credentials == "" ? null : (var.credentials)
}

resource "google_project_service" "services" {
  for_each                   = toset(local.services)
  service                    = each.value
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

data "google_project" "project" {
  depends_on = [
    google_project_service.services
  ]
}

resource "google_firebase_project" "default" {
  provider = google-beta

  depends_on = [
    google_project_service.services
  ]
}

resource "google_firebase_web_app" "basic" {
    provider = google-beta
    display_name = "My Firebase App"
}

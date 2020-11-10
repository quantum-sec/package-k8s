# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES PERSISTENT VOLUME CLAIM
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.13"

  required_providers {
    cloudflare = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.13.3"
    }
  }
}

resource "kubernetes_persistent_volume_claim" "claim" {
  metadata {
    name = var.name
  }

  spec {
    access_modes       = var.access_modes
    volume_name        = var.volume_name
    storage_class_name = var.storage_class_name

    resources {
      requests = {
        storage = var.requested_capacity
      }
    }
  }
}

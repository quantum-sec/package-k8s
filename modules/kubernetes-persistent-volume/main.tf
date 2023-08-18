# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES PERSISTENT VOLUME
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 1.2"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.13.3"
    }
  }
}

resource "kubernetes_persistent_volume" "volume" {
  metadata {
    name = var.name
  }

  spec {
    capacity = {
      storage = var.capacity
    }

    storage_class_name = var.storage_class_name
    access_modes       = var.access_modes

    persistent_volume_source {
      dynamic "azure_file" {
        for_each = var.azure_file_share_name != null ? [1] : []

        content {
          share_name  = var.azure_file_share_name
          secret_name = var.azure_storage_account_secret_name
        }
      }

      # TODO: Fill in other storage provider configs as needed.
    }
  }
}

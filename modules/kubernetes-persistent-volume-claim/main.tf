# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES PERSISTENT VOLUME CLAIM
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

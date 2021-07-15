# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES SECRET DEPLOYMENT
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.13"

  required_providers {
    cloudflare = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.2.0"
    }
  }
}

resource "kubernetes_secret" "secret" {
  metadata {
    annotations   = var.annotations
    generate_name = var.generate_name
    labels        = var.labels
    name          = var.name
    namespace     = var.namespace
  }

  type = var.type
  data = var.data
}

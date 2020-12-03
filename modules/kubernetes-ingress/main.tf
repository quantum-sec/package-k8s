# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES INGRESS DEPLOYMENT
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

resource "kubernetes_ingress" "ingress" {
  metadata {
    annotations   = var.annotations
    generate_name = var.generate_name
    labels        = var.labels
    name          = var.name
    namespace     = var.namespace
  }

  spec {
    backend {
      service_name = var.service_name
      service_port = var.service_port
    }
    rule {
      host = var.host

      http {
        dynamic "path" {
          for_each = var.paths
          content {

            path = path.value.path
            dynamic "backend" {
              for_each = try(path.value.backend, null) != null ? [1] : []
              content {

                service_name = var.service_name
                service_port = var.service_port
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = var.hosts
      secret_name = var.secret_name
    }
  }
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES SERVICE
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.12"
}

resource "kubernetes_service" "service" {
  metadata {
    annotations = var.annotations
    labels      = var.labels
    name        = var.name
    namespace   = var.namespace
  }

  spec {
    cluster_ip                  = var.cluster_ip
    external_ips                = var.external_ips
    external_name               = var.external_name
    external_traffic_policy     = var.external_traffic_policy
    load_balancer_ip            = var.load_balancer_ip
    load_balancer_source_ranges = var.load_balancer_source_ranges
    session_affinity            = var.session_affinity
    type                        = var.type

    selector = {
      app = var.selector
    }

    dynamic "port" {
      for_each = var.port

      content {
        name        = port.value.name
        port        = port.value.port
        target_port = port.value.targetPort
        protocol    = port.value.protocol
      }
    }
  }
}

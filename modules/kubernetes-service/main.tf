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

  timeouts {
    # This represents an increase of 30 minutes on the default timeout. This is due to caching of the AKS managed
    # identity preventing the correct allocation of resources from other resource groups. A refresh cannot be triggered.
    # This has no other effect in GKE or EKS environments.
    # See: https://docs.microsoft.com/en-us/azure/role-based-access-control/troubleshooting#role-assignment-changes-are-not-being-detected
    create = "40m"
  }
}

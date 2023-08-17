# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES DEPLOYMENT FROM A YAML DEFINITION
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

locals {
  service  = yamldecode(var.service_yaml)
  metadata = local.service["metadata"]
  spec     = local.service["spec"]
}

module "kubernetes_service" {
  source = "../kubernetes-service"

  # METADATA
  annotations = try(local.metadata["annotations"], null)
  name        = try(local.metadata["name"], null)
  labels      = try(local.metadata["labels"], null)
  namespace   = try(local.metadata["namespace"], null)

  # SPEC
  cluster_ip                  = try(local.spec["clusterIP"], null)
  external_ips                = try(local.spec["externalIPs"], null)
  external_name               = try(local.spec["externalName"], null)
  external_traffic_policy     = try(local.spec["externalTrafficPolicy"], null)
  load_balancer_ip            = try(local.spec["loadBalancerIP"], null)
  load_balancer_source_ranges = try(local.spec["loadBalancerSourceRanges"], null)
  port                        = try(local.spec["ports"], [])
  selector                    = try(local.spec["selector"]["app"], null)
  session_affinity            = try(local.spec["sessionAffinity"], null)
  type                        = local.spec["type"]
}

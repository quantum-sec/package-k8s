# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES INGRESS FROM A YAML DEFINITION
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

locals {
  ingress  = yamldecode(var.ingress_yaml)
  metadata = local.ingress["metadata"]
  spec     = local.ingress["spec"]
}

module "kubernetes_ingress" {
  source = "../kubernetes-ingress"

  # METADATA
  annotations = try(local.metadata["annotations"], null)
  name        = try(local.metadata["name"], null)
  labels      = try(local.metadata["labels"], null)
  namespace   = try(local.metadata["namespace"], null)

  # SPEC
  service_name = try(local.spec["backend"]["serviceName"], null)
  service_port = try(local.spec["backend"]["service_port"], null)
  host         = try(local.spec["rule"]["host"], null)
  paths        = try(local.spec["rule"]["http"]["paths"], null)
  hosts        = try(local.spec["tls"]["hosts"], [])
  secret_name  = try(local.spec["tls"]["secret_name"], null)
}

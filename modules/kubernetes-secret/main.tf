# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES SECRET DEPLOYMENT
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# SETUP THE LOCAL PROVIDER
# We use a local provider here because it needs to be configured separately from the cloud provider. We also need to
# use output variables from other modules to populate configuration of this provider.
# ---------------------------------------------------------------------------------------------------------------------
provider "kubernetes" {
  version = "1.12.0"

  host = var.host

  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate

  load_config_file = false
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES DEPLOYMENT
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

resource "kubernetes_deployment" "deployment" {

  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = var.annotations
    labels      = var.labels
  }

  spec {
    replicas                  = var.replicas
    paused                    = var.paused
    min_ready_seconds         = var.min_ready_seconds
    progress_deadline_seconds = var.progress_deadline_seconds
    revision_history_limit    = var.revision_history_limit

    strategy {
      type = var.strategy

      dynamic "rolling_update" {
        for_each = var.strategy == "RollingUpdate" ? [0] : []

        content {
          max_surge       = var.max_surge
          max_unavailable = var.max_unavailable
        }
      }
    }

    selector {
      match_labels = var.selector
    }

    template {
      metadata {
        labels = var.labels
      }

      spec {
        active_deadline_seconds          = var.active_deadline_seconds
        automount_service_account_token  = var.automount_service_account_token
        host_ipc                         = var.use_host_ipc_namespace
        host_network                     = var.use_host_network
        host_pid                         = var.use_host_pid_namespace
        hostname                         = var.pod_hostname
        dns_policy                       = var.dns_policy
        node_name                        = var.node_name
        node_selector                    = var.node_selector
        priority_class_name              = var.priority_class_name
        restart_policy                   = var.restart_policy
        service_account_name             = var.service_account_name
        share_process_namespace          = var.share_process_namespace
        subdomain                        = var.subdomain
        termination_grace_period_seconds = var.termination_grace_period_seconds

        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                dynamic "match_expressions" {
                  for_each = var.required_node_affinity_rules

                  content {
                    key      = match_expressions["key"]
                    operator = match_expressions["operator"]
                    values   = match_expressions["values"]
                  }
                }
              }
            }

            preferred_during_scheduling_ignored_during_execution {
              weight = 0
              preference {
                dynamic "match_expressions" {
                  for_each = var.preferred_node_affinity_rules

                  content {
                    key      = match_expressions["key"]
                    operator = match_expressions["operator"]
                    values   = match_expressions["values"]
                  }
                }
              }
            }
          }

          pod_affinity {

          }

          pod_anti_affinity {

          }
        }

        container {
          name = ""
        }

        init_container {
          name = ""
        }


        dns_config {

        }

        host_aliases {
          hostnames = []
          ip        = ""
        }



        image_pull_secrets {
          name = ""
        }


        security_context {

        }

        toleration {

        }

        volume {

        }

      }
    }
  }
}

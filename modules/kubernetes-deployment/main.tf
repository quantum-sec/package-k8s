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

locals {
  has_node_affinity_rules     = var.required_node_affinity_rules != null || var.preferred_node_affinity_rules != null
  has_pod_affinity_rules      = var.required_pod_affinity_label_selector != null || var.preferred_pod_affinity_label_selector != null
  has_pod_anti_affinity_rules = var.required_pod_anti_affinity_label_selector != null || var.preferred_pod_anti_affinity_label_selector != null
  has_affinity_rules          = local.has_node_affinity_rules || local.has_pod_affinity_rules || local.has_pod_anti_affinity_rules
  has_dns_config              = var.dns_nameservers != null || var.dns_search_domains != null || var.dns_resolver_options != null
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

        dynamic "affinity" {
          for_each = local.has_affinity_rules == true ? [1] : []

          content {
            dynamic "node_affinity" {
              for_each = local.has_node_affinity_rules == true ? [1] : []

              content {
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = var.required_node_affinity_rules != null ? [1] : []

                  content {
                    node_selector_term {
                      dynamic "match_expressions" {
                        for_each = coalesce(var.required_node_affinity_rules, [])

                        content {
                          key      = match_expressions["key"]
                          operator = match_expressions["operator"]
                          values   = match_expressions["values"]
                        }
                      }
                    }
                  }
                }

                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = var.preferred_node_affinity_rules != null ? [1] : []

                  content {
                    weight = 1
                    preference {
                      dynamic "match_expressions" {
                        for_each = coalesce(var.preferred_node_affinity_rules, [])

                        content {
                          key      = match_expressions["key"]
                          operator = match_expressions["operator"]
                          values   = match_expressions["values"]
                        }
                      }
                    }
                  }
                }
              }
            }

            dynamic "pod_affinity" {
              for_each = local.has_pod_affinity_rules == true ? [1] : []

              content {
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = var.required_pod_affinity_label_selector != null ? [1] : []

                  content {
                    namespaces   = var.required_pod_affinity_namespaces
                    topology_key = var.required_pod_affinity_topology_key
                    label_selector {
                      match_labels = var.required_pod_affinity_label_selector
                    }
                  }
                }

                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = var.preferred_pod_affinity_label_selector != null ? [1] : []

                  content {
                    weight = 1
                    pod_affinity_term {
                      namespaces   = var.preferred_pod_affinity_namespaces
                      topology_key = var.preferred_pod_affinity_topology_key
                      label_selector {
                        match_labels = var.preferred_pod_affinity_label_selector
                      }
                    }
                  }
                }
              }
            }

            dynamic "pod_anti_affinity" {
              for_each = local.has_pod_anti_affinity_rules == true ? [1] : []

              content {
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = var.required_pod_anti_affinity_label_selector != null ? [1] : []

                  content {
                    namespaces   = var.required_pod_anti_affinity_namespaces
                    topology_key = var.required_pod_anti_affinity_topology_key
                    label_selector {
                      match_labels = var.required_pod_anti_affinity_label_selector
                    }
                  }
                }

                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = var.preferred_pod_anti_affinity_label_selector != null ? [1] : []

                  content {
                    weight = 1
                    pod_affinity_term {
                      namespaces   = var.preferred_pod_anti_affinity_namespaces
                      topology_key = var.preferred_pod_anti_affinity_topology_key
                      label_selector {
                        match_labels = var.preferred_pod_anti_affinity_label_selector
                      }
                    }
                  }
                }
              }
            }
          }
        }

        dynamic "container" {
          for_each = var.containers

          content {
            name  = container.value.name
            image = container.value.image
            args  = container.value.args

            dynamic "env" {
              for_each = coalesce(container.value.env, [])

              content {
                name  = env.value.name
                value = env.value.value
              }
            }

            dynamic "volume_mount" {
              for_each = coalesce(container.value.volumeMounts, [])

              content {
                name       = volume_mount.value.name
                mount_path = volume_mount.value.mountPath
              }
            }

            dynamic "port" {
              for_each = coalesce(container.value.ports, [])

              content {
                container_port = try(port.value.container_port, port.value.containerPort)
                protocol       = try(port.value.protocol, "TCP")
              }
            }

            resources {
              limits {
                cpu    = container.value.resources.limits.cpu
                memory = container.value.resources.limits.memory
              }
              requests {
                cpu    = container.value.resources.requests.cpu
                memory = container.value.resources.requests.memory
              }
            }
          }
        }

        dynamic "volume" {
          for_each = var.volumes

          content {
            name = volume.value.name

            dynamic "secret" {
              for_each = coalesce(volume.value.secret, {})

              content {
                secret_name = secret.value.secretName

                dynamic "items" {
                  for_each = coalesce(secret.value.items, [])

                  content {
                    key  = items.value.key
                    path = items.value.path
                  }
                }
              }
            }
          }
        }

        dynamic "dns_config" {
          for_each = local.has_dns_config == true ? [1] : []

          content {
            nameservers = var.dns_nameservers
            searches    = var.dns_search_domains

            dynamic "option" {
              for_each = coalesce(var.dns_resolver_options, [])

              content {
                name  = option.value.name
                value = option.value.value
              }
            }
          }
        }

        dynamic "host_aliases" {
          for_each = coalesce(var.host_aliases, [])

          content {
            hostnames = host_aliases.value.hostnames
            ip        = host_aliases.value.ip
          }
        }

        dynamic "image_pull_secrets" {
          for_each = coalesce(var.image_pull_secret_names, [])

          content {
            name = image_pull_secrets.value
          }
        }
      }
    }
  }
}

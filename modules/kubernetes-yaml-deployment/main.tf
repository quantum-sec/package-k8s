# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES DEPLOYMENT FROM A YAML DEFINITION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.12"
}

locals {
  deployment    = yamldecode(var.deployment_yaml)
  metadata      = local.deployment["metadata"]
  spec          = local.deployment["spec"]
  template      = local.spec["template"]
  template_spec = local.template["spec"]
}

module "kubernetes_deployment" {
  source = "../kubernetes-deployment"

  # DEPLOYMENT METADATA
  annotations = try(local.metadata["annotations"], null)
  name        = try(local.metadata["name"], null)
  labels      = try(local.metadata["labels"], null)
  namespace   = try(local.metadata["namespace"], null)

  # DEPLOYMENT SPEC
  min_ready_seconds         = try(local.spec["minReadySeconds"], null)
  paused                    = try(local.spec["paused"], null)
  progress_deadline_seconds = try(local.spec["progressDeadlineSeconds"], null)
  replicas                  = try(local.spec["replicas"], null)
  revision_history_limit    = try(local.spec["revisionHistoryLimit"], null)
  strategy                  = try(local.spec["strategy"]["type"], null)
  max_surge                 = try(local.spec["strategy"]["maxSurge"], null)
  max_unavailable           = try(local.spec["strategy"]["maxUnavailable"], null)
  selector                  = try(local.spec["selector"]["matchLabels"], null)
  active_deadline_seconds   = try(local.spec["activeDeadlineSeconds"], null)

  # TEMPLATE SPEC
  containers                       = try(local.template_spec["containers"], null)
  dns_policy                       = try(local.template_spec["dnsPolicy"], null)
  host_aliases                     = try(local.template_spec["hostAliases"], null)
  image_pull_secret_names          = try(local.template_spec["imagePullSecrets"], null)
  pod_hostname                     = try(local.template_spec["hostname"], null)
  node_name                        = try(local.template_spec["nodeName"], null)
  node_selector                    = try(local.template_spec["nodeSelector"], null)
  priority_class_name              = try(local.template_spec["priorityClassName"], null)
  restart_policy                   = try(local.template_spec["restartPolicy"], null)
  service_account_name             = try(local.template_spec["serviceAccountName"], null)
  share_process_namespace          = try(local.template_spec["shareProcessNamespace"], null)
  subdomain                        = try(local.template_spec["subdomain"], null)
  termination_grace_period_seconds = try(local.template_spec["terminationGracePeriodSeconds"], null)
  volumes                          = try(local.template_spec["volumes"], null)

  # AFFINITY RULES
  required_node_affinity_rules               = try(local.template_spec["affinity"]["nodeAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"], null)
  preferred_node_affinity_rules              = try(local.template_spec["affinity"]["nodeAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"], null)
  required_pod_affinity_label_selector       = try(local.template_spec["affinity"]["podAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["labelSelector"], null)
  required_pod_affinity_topology_key         = try(local.template_spec["affinity"]["podAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["topologyKey"], null)
  required_pod_affinity_namespaces           = try(local.template_spec["affinity"]["podAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["namespaces"], null)
  preferred_pod_affinity_label_selector      = try(local.template_spec["affinity"]["podAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["labelSelector"], null)
  preferred_pod_affinity_topology_key        = try(local.template_spec["affinity"]["podAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["topologyKey"], null)
  preferred_pod_affinity_namespaces          = try(local.template_spec["affinity"]["podAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["namespaces"], null)
  required_pod_anti_affinity_label_selector  = try(local.template_spec["affinity"]["podAntiAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["labelSelector"], null)
  required_pod_anti_affinity_topology_key    = try(local.template_spec["affinity"]["podAntiAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["topologyKey"], null)
  required_pod_anti_affinity_namespaces      = try(local.template_spec["affinity"]["podAntiAffinity"]["requiredDuringSchedulingIgnoredDuringExecution"]["namespaces"], null)
  preferred_pod_anti_affinity_label_selector = try(local.template_spec["affinity"]["podAntiAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["labelSelector"], null)
  preferred_pod_anti_affinity_topology_key   = try(local.template_spec["affinity"]["podAntiAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["topologyKey"], null)
  preferred_pod_anti_affinity_namespaces     = try(local.template_spec["affinity"]["podAntiAffinity"]["preferredDuringSchedulingIgnoredDuringExecution"]["namespaces"], null)

  # DNS CONFIGURATION
  dns_nameservers      = try(local.template_spec["dnsConfig"]["nameservers"], null)
  dns_resolver_options = try(local.template_spec["dnsConfig"]["options"], null)
  dns_search_domains   = try(local.template_spec["dnsConfig"]["searches"], null)
}

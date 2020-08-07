# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES DEPLOYMENT FROM A YAML DEFINITION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.12"
}

locals {
  deployment = yamldecode(var.deployment_yaml)
}

module "kubernetes_deployment" {
  source = "../kubernetes-deployment"

  # PROVIDER CONFIGURATION
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
  host                   = var.host

  # DEPLOYMENT METADATA
  annotations = local.deployment.metadata.annotations
  name        = local.deployment.metadata.name
  labels      = local.deployment.metadata.labels
  namespace   = local.deployment.metadata.namespace

  # DEPLOYMENT SPEC
  min_ready_seconds         = local.deployment.spec.minReadySeconds
  paused                    = local.deployment.spec.paused
  progress_deadline_seconds = local.deployment.spec.progressDeadlineSeconds
  replicas                  = local.deployment.spec.replicas
  revision_history_limit    = local.deployment.spec.revisionHistoryLimit
  strategy                  = local.deployment.spec.strategy.type
  max_surge                 = local.deployment.spec.strategy.maxSurge
  max_unavailable           = local.deployment.spec.strategy.maxUnavailable
  selector                  = local.deployment.spec.selector.matchLabels
  active_deadline_seconds   = local.deployment.spec.activeDeadlineSeconds

  # TEMPLATE SPEC
  containers                       = local.deployment.spec.template.spec.containers
  dns_policy                       = local.deployment.spec.template.spec.dnsPolicy
  host_aliases                     = local.deployment.spec.template.spec.hostAliases
  image_pull_secret_names          = local.deployment.spec.template.spec.imagePullSecrets
  pod_hostname                     = local.deployment.spec.template.spec.hostname
  node_name                        = local.deployment.spec.template.spec.nodeName
  node_selector                    = local.deployment.spec.template.spec.nodeSelector
  priority_class_name              = local.deployment.spec.template.spec.priorityClassName
  restart_policy                   = local.deployment.spec.template.spec.restartPolicy
  service_account_name             = local.deployment.spec.template.spec.serviceAccountName
  share_process_namespace          = local.deployment.spec.template.spec.shareProcessNamespace
  subdomain                        = local.deployment.spec.template.spec.subdomain
  termination_grace_period_seconds = local.deployment.spec.template.spec.terminationGracePeriodSeconds

  # AFFINITY RULES
  required_node_affinity_rules               = local.deployment.spec.template.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution
  preferred_node_affinity_rules              = local.deployment.spec.template.spec.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution
  required_pod_affinity_label_selector       = local.deployment.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.labelSelector
  required_pod_affinity_topology_key         = local.deployment.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.topologyKey
  required_pod_affinity_namespaces           = local.deployment.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.namespaces
  preferred_pod_affinity_label_selector      = local.deployment.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.labelSelector
  preferred_pod_affinity_topology_key        = local.deployment.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.topologyKey
  preferred_pod_affinity_namespaces          = local.deployment.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.namespaces
  required_pod_anti_affinity_label_selector  = local.deployment.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.labelSelector
  required_pod_anti_affinity_topology_key    = local.deployment.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.topologyKey
  required_pod_anti_affinity_namespaces      = local.deployment.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.namespaces
  preferred_pod_anti_affinity_label_selector = local.deployment.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.labelSelector
  preferred_pod_anti_affinity_topology_key   = local.deployment.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.topologyKey
  preferred_pod_anti_affinity_namespaces     = local.deployment.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.namespaces

  # DNS CONFIGURATION
  dns_nameservers      = local.deployment.spec.template.spec.dnsConfig.nameservers
  dns_resolver_options = local.deployment.spec.template.spec.dnsConfig.options
  dns_search_domains   = local.deployment.spec.template.spec.dnsConfig.searches
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A KUBERNETES DEPLOYMENT FROM A YAML DEFINITION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.12"
}

module "kubernetes_deployment" {
  source = "../kubernetes-deployment"

  # PROVIDER CONFIGURATION
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
  host                   = var.host

  # DEPLOYMENT METADATA
  annotations = var.deployment_yaml.metadata.annotations
  name        = var.deployment_yaml.metadata.name
  labels      = var.deployment_yaml.metadata.labels
  namespace   = var.deployment_yaml.metadata.namespace

  # DEPLOYMENT SPEC
  min_ready_seconds         = var.deployment_yaml.spec.minReadySeconds
  paused                    = var.deployment_yaml.spec.paused
  progress_deadline_seconds = var.deployment_yaml.spec.progressDeadlineSeconds
  replicas                  = var.deployment_yaml.spec.replicas
  revision_history_limit    = var.deployment_yaml.spec.revisionHistoryLimit
  strategy                  = var.deployment_yaml.spec.strategy.type
  max_surge                 = var.deployment_yaml.spec.strategy.maxSurge
  max_unavailable           = var.deployment_yaml.spec.strategy.maxUnavailable
  selector                  = var.deployment_yaml.spec.selector.matchLabels
  active_deadline_seconds   = var.deployment_yaml.spec.activeDeadlineSeconds

  # TEMPLATE SPEC
  containers                       = var.deployment_yaml.spec.template.spec.containers
  dns_policy                       = var.deployment_yaml.spec.template.spec.dnsPolicy
  dns_config                       = var.deployment_yaml.spec.template.spec.dnsConfig
  host_aliases                     = var.deployment_yaml.spec.template.spec.hostAliases
  image_pull_secret_names          = var.deployment_yaml.spec.template.spec.imagePullSecrets
  pod_hostname                     = var.deployment_yaml.spec.template.spec.hostname
  node_name                        = var.deployment_yaml.spec.template.spec.nodeName
  node_selector                    = var.deployment_yaml.spec.template.spec.nodeSelector
  priority_class_name              = var.deployment_yaml.spec.template.spec.priorityClassName
  restart_policy                   = var.deployment_yaml.spec.template.spec.restartPolicy
  service_account_name             = var.deployment_yaml.spec.template.spec.serviceAccountName
  share_process_namespace          = var.deployment_yaml.spec.template.spec.shareProcessNamespace
  subdomain                        = var.deployment_yaml.spec.template.spec.subdomain
  termination_grace_period_seconds = var.deployment_yaml.spec.template.spec.terminationGracePeriodSeconds

  # AFFINITY RULES
  required_node_affinity_rules               = var.deployment_yaml.spec.template.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution
  preferred_node_affinity_rules              = var.deployment_yaml.spec.template.spec.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution
  required_pod_affinity_label_selector       = var.deployment_yaml.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.labelSelector
  required_pod_affinity_topology_key         = var.deployment_yaml.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.topologyKey
  required_pod_affinity_namespaces           = var.deployment_yaml.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.namespaces
  preferred_pod_affinity_label_selector      = var.deployment_yaml.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.labelSelector
  preferred_pod_affinity_topology_key        = var.deployment_yaml.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.topologyKey
  preferred_pod_affinity_namespaces          = var.deployment_yaml.spec.template.spec.affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution.namespaces
  required_pod_anti_affinity_label_selector  = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.labelSelector
  required_pod_anti_affinity_topology_key    = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.topologyKey
  required_pod_anti_affinity_namespaces      = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution.namespaces
  preferred_pod_anti_affinity_label_selector = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.labelSelector
  preferred_pod_anti_affinity_topology_key   = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.topologyKey
  preferred_pod_anti_affinity_namespaces     = var.deployment_yaml.spec.template.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.namespaces

  # DNS CONFIGURATION
  dns_nameservers      = var.deployment_yaml.spec.template.spec.dnsConfig.nameservers
  dns_resolver_options = var.deployment_yaml.spec.template.spec.dnsConfig.options
  dns_search_domains   = var.deployment_yaml.spec.template.spec.dnsConfig.searches
}

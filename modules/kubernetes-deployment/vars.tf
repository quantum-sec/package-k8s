# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "host" {
  description = "The Kubernetes cluster's API endpoint URL."
  type        = string
}

variable "client_certificate" {
  description = "The client certificate (in PEM format) used to authenticate to the Kubernetes cluster."
  type        = string
}

variable "client_key" {
  description = "The client private key (in PEM format) used to encrypt communicates with the Kubernetes cluster."
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The cluster's CA certificate (in PEM format) used to validate remote host identity."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOYMENT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name of the deployment. Must be unique within the cluster or namespace, and cannot be updated."
  type        = string
}

variable "namespace" {
  description = "The namespace within which the name of the deployment must be unique."
  type        = string
}

variable "annotations" {
  description = "An unstructured key value map stored with the deployment that may be used to store arbitrary metadata."
  type        = map(string)
  default     = null
}

variable "labels" {
  description = "A map of string keys and values that can be used to organize and categorize (scope and select) the deployment."
  type        = map(string)
  default     = null
}

variable "wait_for_rollout" {
  description = "Whether or not to wait for the deployment to successfully roll out."
  type        = bool
  default     = true
}

variable "min_ready_seconds" {
  description = "The minimum number of seconds for which a newly created pod should be ready without any of its containers crashing, for it to be considered available."
  type        = number
  default     = 0
}

variable "paused" {
  description = "Whether or not the deployment is paused."
  type        = bool
  default     = false
}

variable "progress_deadline_seconds" {
  description = "The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a `ProgressDeadlineExceeded` reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused."
  type        = number
  default     = 600
}

variable "replicas" {
  description = "The number of desired replicas."
  type        = number
  default     = 1
}

variable "revision_history_limit" {
  description = "The number of old `ReplicaSet`s to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified."
  type        = number
  default     = 10
}

variable "strategy" {
  description = "The deployment strategy to use to replace existing pods with new ones. One of `Recreate` or `RollingUpdate`."
  type        = string
  default     = "RollingUpdate"
}

variable "max_surge" {
  description = "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (e.g. `5`) or a percentage of desired pods (e.g. `10%`). This cannot be `0` if `MaxUnavailable` is `0`. Absolute number is calculated from percentage by rounding up."
  type        = string
  default     = "25%"
}

variable "max_unavailable" {
  description = "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (e.g. `5`) or a percentage of desired pods (e.g. `10%`). This cannot be `0` if `MaxSurge` is `0`. Absolute number is calculated from percentage by rounding down."
  type        = string
  default     = "25%"
}

variable "selector" {
  description = "A label query over pods that should match the Replicas count. Label keys and values that must match in order to be controlled by this deployment. Must match labels (`metadata.0.labels`)."
  type        = string
  default     = null
}

variable "active_deadline_seconds" {
  description = "The duration in seconds the pod may be active on the node relative to `StartTime` before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer."
  type        = number
  default     = null
}

variable "automount_service_account_token" {
  description = "Whether or not a service account token should be automatically mounted."
  type        = bool
  default     = false
}

variable "use_host_ipc_namespace" {
  description = "Whether or not to use the host's IPC namespace."
  type        = bool
  default     = false
}

variable "use_host_network" {
  description = "Whether or not host networking is requested for this pod and whether it will use the host's network namespace. If this option is set, the ports that will be used must be specified."
  type        = bool
  default     = false
}

variable "use_host_pid_namespace" {
  description = "Whether or not to use the host's PID namespace."
  type        = bool
  default     = false
}

variable "pod_hostname" {
  description = "Specifies theo hostname of the pod. If not specified, the pod's hostname will be set to a system-defined value."
  type        = string
  default     = null
}

variable "dns_policy" {
  description = "The DNS policy that will be set for containers within the pod. One of `ClusterFirstWithHostNet`, `ClusterFirst`, `Default`, or `None`. DNS parameters given in `dns_config` will be merged with this policy. To have DNS options set along with `use_host_network`, you have to specify DNS policy explicitly with `ClusterFirstWithHostNet`."
  type        = string
  default     = "ClusterFirst"
}

variable "node_name" {
  description = "When specified the scheduling request will attempt to locate the pod on the specified node granted that it fits resource requirements."
  type        = string
  default     = null
}

variable "node_selector" {
  description = "A selector which must be true for the pod to fit on a node. It must match a node's labels for the pod to be scheduled on that node."
  type        = string
  default     = null
}

variable "priority_class_name" {
  description = "If specified, indicates the pod's priority. `system-node-critical` and `system-cluster-critical` are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a `PriorityClass` object with that name. If not specified, the pod priority will be default or zero if there is no default."
  type        = string
  default     = null
}

variable "restart_policy" {
  description = "The restart policy for all containers within the pod. One of `Always`, `OnFailure`, or `Never`."
  type        = string
  default     = "Always"
}

variable "service_account_name" {
  description = "The name of the service account to use to run this pod."
  type        = string
  default     = null
}

variable "share_process_namespace" {
  description = "Whether or not a single process namespace is shared between all of the containers in this pod. When this is set, containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. `use_host_pid_namespace` and `share_process_namespace` cannot both be set."
  type        = bool
  default     = null
}

variable "subdomain" {
  description = "The subdomain used when creating the fully qualified pod hostname. If not specified, the pod will not include a domain name."
  type        = string
  default     = null
}

variable "termination_grace_period_seconds" {
  description = "The duration in seconds the pod needs to terminate gracefully. Must be a non-negative integer."
  type        = number
  default     = null
}

variable "required_node_affinity_rules" {
  description = "A set of node selector queries that must be satisfied when scheduling the deployment."
  type = set(object({
    key      = string,
    operator = string,
    values   = list(string)
  }))
  default = []
}

variable "preferred_node_affinity_rules" {
  description = "A set of node selector queries that the scheduler will evaluate to determine the preferred location of the pod, however it may choose a node that violates one or more of the expressions."
  type = set(object({
    key      = string,
    operator = string,
    values   = list(string)
  }))
  default = []
}

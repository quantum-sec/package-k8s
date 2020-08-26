variable "name" {
  description = "The name of the deployment. Must be unique within the cluster or namespace, and cannot be updated."
  type        = string
}

variable "namespace" {
  description = "The namespace within which the name of the deployment must be unique."
  type        = string
  default     = null
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

variable "cluster_ip" {
  description = "The IP address of the service. It is usually assigned randomly by the master. If an address is specified manually and is not in use by others, it will be allocated to the service; otherwise creation of the service will fail. `None` can be specified for headless services when proxying is not required. Ignored if type is `ExternalName`."
  type        = string
  default     = null
}

variable "external_ips" {
  description = "A list of IP addresses for which nodes in the cluster will also accept traffic for this service. These IPs are not managed by Kubernetes. The user is responsible for ensuring that traffic arrives at a node with this IP. A common example is external load balancers that are not part of the Kubernetes system."
  type        = set(string)
  default     = null
}

variable "external_name" {
  description = "The external reference that kubedns or equivalent will return as a CNAME record for this service. No proxying will be involved. Must be a valid DNS name and requires `type` to be `ExternalName`."
  type        = string
  default     = null
}

variable "external_traffic_policy" {
  description = "Denotes if this service desires to route external traffic to node-local or cluster-wide endpoints. One of `Local` or `Cluster`."
  type        = string
  default     = null
}

variable "load_balancer_ip" {
  description = "The IP address assigned to the load balancer."
  type        = string
  default     = null
}

variable "load_balancer_source_ranges" {
  description = "If specified and supported by the platform, this will restrict traffic through the cloud provider load balancer to the specified client IPs."
  type        = set(string)
  default     = null
}

variable "port" {
  description = "The list of ports that are exposed by this service."
  type = set(object({
    name       = string,
    port       = number,
    protocol   = string,
    targetPort = number,
  }))
  default = []
}

variable "selector" {
  description = "Route service traffic to pods with label keys and values matching the selector. Only applies type types `ClusterIP`, `NodePort`, and `Load Balancer`."
  type        = string
  default     = null
}

variable "session_affinity" {
  description = "Used to maintain session affinity. Supports `ClientIP` and `None`."
  type        = string
  default     = "None"
}

variable "type" {
  description = "Determines how the service is exposed."
  type        = string
  default     = "ClusterIP"
}

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

variable "deployment_yaml" {
  description = "The YAML definition of the Kubernetes deployment."
  type        = object
}

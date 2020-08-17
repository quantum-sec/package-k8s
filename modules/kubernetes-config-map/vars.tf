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
  description = "The name of the config map. Must be unique and cannot be updated."
  type        = string
}

variable "namespace" {
  description = "The namespace within which the name of the config map must be unique."
  type        = string
  default     = null
}

variable "annotations" {
  description = "An unstructured key value map stored with the config map that may be used to store arbitrary metadata."
  type        = map(string)
  default     = null
}

variable "labels" {
  description = "A map of string keys and values that can be used to organize and categorize (scope and select) the config map."
  type        = map(string)
  default     = null
}

variable "generate_name" {
  description = "Prefix, used by the server, to generate a unique name only if the `name` field has not been provided."
  type        = string
  default     = null
}

variable "data" {
  description = "A map of the configuration data."
  type        = map(string)
  default     = null
}

variable "binary_data" {
  description = "BinaryData can contain byte sequences that are not in the UTF-8 range. Each key must consist of alphanumeric characters, '-', '_' or '.'"
  type        = map(string)
  default     = null
}
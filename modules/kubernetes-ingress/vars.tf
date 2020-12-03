# ---------------------------------------------------------------------------------------------------------------------
# DEPLOYMENT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "Name of the service, must be unique. Cannot be updated."
  type        = string
}

variable "namespace" {
  description = "Namespace defines the space within which name of the service must be unique."
  type        = string
  default     = null
}

variable "annotations" {
  description = "An unstructured key value map stored with the config map that may be used to store arbitrary metadata."
  type        = map(string)
  default     = null
}

variable "labels" {
  description = "Map of string keys and values that can be used to organize and categorize (scope and select) the service."
  type        = map(string)
  default     = null
}

variable "generate_name" {
  description = "Prefix, used by the server, to generate a unique name only if the `name` field has not been provided."
  type        = string
  default     = null
}

variable "service_name" {
  description = "Specifies the name of the referenced service."
  type        = string
  default     = null
}

variable "service_port" {
  description = "Specifies the port of the referenced service."
  type        = number
  default     = null
}

variable "paths" {
  description = "http is a list of http selectors pointing to backends."
  type = set(object({
    path = string
    backend = set(object({
      service_name = string
      service_port = string
    }))
  }))
}

variable "secret_name" {
  description = "Specifies the port of the referenced service."
  type        = string
  default     = null
}

variable "hosts" {
  description = "Hosts are a list of hosts included in the TLS certificate."
  type        = set(string)
  default     = []
}

variable "host" {
  description = " Host is the fully qualified domain name of a network host."
  type        = string
  default     = null
}

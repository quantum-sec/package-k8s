variable "name" {
  description = "The name of the persistent volume claim."
  type        = string
}

variable "volume_name" {
  description = "The name of the persistent volume to which this claim is attached."
  type        = string
}

variable "access_modes" {
  description = "A list of all access modes that can be used to mount this volume."
  type        = set(string)
  default     = ["ReadWriteMany"]
}

variable "storage_class_name" {
  description = "The name of the storage class this volume should be provisioned as."
  type        = string
  default     = "default"
}

variable "requested_capacity" {
  description = "The requested capacity of the persistent volume in standard Kubernetes notation (e.g. `10GBi` = 10 gibibytes)."
  type        = string
}

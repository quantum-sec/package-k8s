variable "name" {
  description = "The name of the persistent volume."
  type        = string
}

variable "capacity" {
  description = "The capacity of the persistent volume in standard Kubernetes notation (e.g. `10GBi` = 10 gibibytes)."
  type        = string
}

variable "storage_class_name" {
  description = "The name of the storage class this volume should be provisioned as."
  type        = string
  default     = "default"
}

variable "access_modes" {
  description = "A list of all access modes that can be used to mount this volume."
  type        = set(string)
  default     = ["ReadWriteMany"]
}

variable "azure_file_share_name" {
  description = "The name of the Azure storage account file share to use."
  type        = string
  default     = null
}

variable "azure_storage_account_secret_name" {
  description = "The name of the Kubernetes secret that contains the connection details (`azurestorageaccountname` and `azurestorageaccountkey`) to connect to the storage account."
  type        = string
  default     = null
}

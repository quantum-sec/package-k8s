output "name" {
  description = "The name of the persistent volume."
  value       = kubernetes_persistent_volume.volume.metadata.0.name
}

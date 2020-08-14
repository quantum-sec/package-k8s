output "generation" {
  description = "A sequence number representing a specific generation of the desired state."
  value       = kubernetes_config_map.config.generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this config map that can be used by clients to determine when secret has changed. "
  value       = kubernetes_config_map.config.resource_version
}

output "self_link" {
  description = "A URL representing this config map."
  value       = kubernetes_config_map.config.self_link
}

output "uid" {
  description = "The unique in time and space value for this config map."
  value       = kubernetes_config_map.config.uid
}

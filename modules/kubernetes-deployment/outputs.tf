output "generation" {
  description = "A sequence number representing the specific generation of the desired state."
  value       = kubernetes_deployment.deployment.metadata.generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this deployment that can be used by clients to determine when the secret has changed."
  value       = kubernetes_deployment.deployment.metadata.resource_version
}

output "self_link" {
  description = "A URL representing this deployment."
  value       = kubernetes_deployment.deployment.metadata.self_link
}

output "uid" {
  description = "The unique identifier of this deployment."
  value       = kubernetes_deployment.deployment.metadata.uid
}

output "generation" {
  description = "A sequence number representing the specific generation of the desired state."
  value       = module.kubernetes_deployment.generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this deployment that can be used by clients to determine when the secret has changed."
  value       = module.kubernetes_deployment.resource_version
}

output "self_link" {
  description = "A URL representing this deployment."
  value       = module.kubernetes_deployment.self_link
}

output "uid" {
  description = "The unique identifier of this deployment."
  value       = module.kubernetes_deployment.uid
}

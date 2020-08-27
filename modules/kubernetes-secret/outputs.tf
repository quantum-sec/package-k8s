output "name" {
  description = "The name of the secret."
  value       = var.name
}

output "generation" {
  description = "A sequence number representing the specific generation of the desired state."
  value       = kubernetes_secret.secret.metadata[0].generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this secret that can be used by clients to determine when the secret has changed."
  value       = kubernetes_secret.secret.metadata[0].resource_version
}

output "self_link" {
  description = "A URL representing this secret."
  value       = kubernetes_secret.secret.metadata[0].self_link
}

output "uid" {
  description = "The unique identifier of this secret."
  value       = kubernetes_secret.secret.metadata[0].uid
}

output "generation" {
  description = "A sequence number representing a specific generation of the desired state."
  value       = kubernetes_service.service.metadata[0].generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this service that can be used by clients to determine when the service has changed."
  value       = kubernetes_service.service.metadata[0].resource_version
}

output "self_link" {
  description = "A URL representing this service."
  value       = kubernetes_service.service.metadata[0].self_link
}

output "uid" {
  description = "The unique identifier for this service."
  value       = kubernetes_service.service.metadata[0].uid
}

output "load_balancer_ingress" {
  description = "A list containing ingress points for the load balancer (only valid if `type` is `LoadBalancer`)."
  value       = kubernetes_service.service.load_balancer_ingress
}

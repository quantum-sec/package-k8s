output "generation" {
  description = "A sequence number representing a specific generation of the desired state."
  value       = module.kubernetes_service.generation
}

output "resource_version" {
  description = "An opaque value that represents the internal version of this service that can be used by clients to determine when the service has changed."
  value       = module.kubernetes_service.resource_version
}

output "self_link" {
  description = "A URL representing this service."
  value       = module.kubernetes_service.self_link
}

output "uid" {
  description = "The unique identifier for this service."
  value       = module.kubernetes_service.uid
}

output "load_balancer_ingress_ip" {
  description = "The IP which is set for load balancer ingress points that are IP-based."
  value       = module.kubernetes_service.load_balancer_ingress_ip
}

output "load_balancer_ingress_hostname" {
  description = "The Hostname which is set for load balancer ingress points that are DNS-based."
  value       = module.kubernetes_service.load_balancer_ingress_hostname
}

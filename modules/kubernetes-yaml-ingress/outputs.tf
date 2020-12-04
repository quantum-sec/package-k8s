output "load_balancer_ingress" {
  description = "A list containing ingress points for the load-balancer."
  value       = module.kubernetes_ingress.load_balancer_ingress
}

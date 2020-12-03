output "load_balancer_ingress" {
  description = "A list containing ingress points for the load-balancer."
  value       = kubernetes_ingress.ingress.load_balancer_ingress
}

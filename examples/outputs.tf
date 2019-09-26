# NGINX Private IPs
output "private_ips" {
  value = module.aws-nginx-demo.private_ips
}

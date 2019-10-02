output "vpc" {
  description = "AWS VPC ID for the created VPC"
  value       = module.vpc.vpc_id
}

output "private_ips" {
  description = "NGINX Private IPs"
  value       = module.aws-nginx-demo.private_ips
}

output "public_ips" {
  description = "NGINX Public IPs"
  value       = module.aws-nginx-demo.public_ips
}

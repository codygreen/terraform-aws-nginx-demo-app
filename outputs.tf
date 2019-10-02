output "private_ips" {
  description = "NGINX Private IPs"
  value       = module.ec2_cluster.private_ip
}

output "public_ips" {
  description = "NGINX Public IPs"
  value       = module.ec2_cluster.public_ip
}

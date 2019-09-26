# NGINX Private IPs
output "private_ips" {
  value = module.ec2_cluster[*].private_ip
}

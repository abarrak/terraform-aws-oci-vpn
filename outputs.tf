output "ipsec_shared_secret" {
  sensitive   = true
  value       = random_password.ipsec_shared_secret.result
  description = "The IPSec connection shared secret."
}

output "ipsec_initial_cpe_arn" {
  description = "The amazon resource name (arn) of the vpn customer gateway."
  value       = aws_customer_gateway.ipsec_gateway_cpe.arn
}

output "ipsec_vpn_gateway_arn" {
  description = "The amazon resource name (arn) of the vpn gateway."
  value       = aws_vpn_gateway.ipsec_vpn_gateway.arn
}

output "ipsec_vpn_connection_id" {
  description = "The ID for vpn connection resource."
  value       = aws_vpn_connection.ipsec_vpn_connection.id
}

output "ipsec_vpn_connection_tunnel_1_ip" {
  description = "The public ip address of the first vpn tunnel."
  value       = aws_vpn_connection.ipsec_vpn_connection.tunnel1_address
}

output "ipsec_vpn_connection_tunnel_2_ip" {
  description = "The public ip address of the second vpn tunnel"
  value       = aws_vpn_connection.ipsec_vpn_connection.tunnel2_address
}


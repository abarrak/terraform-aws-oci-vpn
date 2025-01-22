##
# tunnel.tf holds the resources related to: aws <=> oci connectivity for cpf shared-services.
#
resource "aws_customer_gateway" "ipsec_gateway_cpe" {
  ip_address  = var.oci_ipsec_gateway_cpe_ip
  type        = "ipsec.1"
  bgp_asn     = 31898    # Oracle's BGP ASN.
  tags        = merge(
    { Name = var.oci_ipsec_gateway_cpe_name },
    var.tags
  )
}

# Creates and attach vpn_connection virtual private gateway to antaris VPC.
resource "aws_vpn_gateway" "ipsec_vpn_gateway" {
  vpc_id = data.aws_vpc.vpc.id
  tags   = merge(
    { Name = var.oci_ipsec_vpn_gateway_name },
    var.tags
  )
}


# Manages a site-to-site vpn connection via internet protocol security (ipsec) vpn
# connection between a vpc and an on-premises network.
resource "aws_vpn_connection" "ipsec_vpn_connection" {
  vpn_gateway_id      = aws_vpn_gateway.ipsec_vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.ipsec_gateway_cpe.id
  type                = "ipsec.1"

  tunnel_inside_ip_version             = "ipv4"
  static_routes_only                   = true
  local_ipv4_network_cidr              = "0.0.0.0/0"
  remote_ipv4_network_cidr             = "0.0.0.0/0"
  tunnel1_inside_cidr                  = "169.254.50.0/30"
  tunnel2_inside_cidr                  = "169.254.51.0/30"
  tunnel1_ike_versions                 = ["ikev2"]
  tunnel2_ike_versions                 = ["ikev2"]
  tunnel1_preshared_key                = random_password.ipsec_shared_secret.result
  tunnel2_preshared_key                = random_password.ipsec_shared_secret.result
  tunnel1_phase1_encryption_algorithms = var.oci_ipsec_vpn_connection_tunnel_encryption_algorithms
  tunnel1_phase2_encryption_algorithms = var.oci_ipsec_vpn_connection_tunnel_encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.oci_ipsec_vpn_connection_tunnel_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.oci_ipsec_vpn_connection_tunnel_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.oci_ipsec_vpn_connection_tunnel_integrity_algorithms
  tunnel1_phase2_integrity_algorithms  = var.oci_ipsec_vpn_connection_tunnel_integrity_algorithms
  tunnel2_phase1_integrity_algorithms  = var.oci_ipsec_vpn_connection_tunnel_integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.oci_ipsec_vpn_connection_tunnel_integrity_algorithms
  tunnel1_phase1_dh_group_numbers      = var.oci_ipsec_vpn_connection_tunnel_dh_group_numbers
  tunnel1_phase2_dh_group_numbers      = var.oci_ipsec_vpn_connection_tunnel_dh_group_numbers
  tunnel2_phase1_dh_group_numbers      = var.oci_ipsec_vpn_connection_tunnel_dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.oci_ipsec_vpn_connection_tunnel_dh_group_numbers

  tags = merge(
    { Name = var.oci_ipsec_vpn_connection_name },
    var.tags
  )

  depends_on = [
    aws_customer_gateway.ipsec_gateway_cpe,
    aws_vpn_gateway.ipsec_vpn_gateway
  ]
}

resource "aws_vpn_connection_route" "ipsec_vpn_connection_routes" {
  count                  = length(var.oci_ipsec_vpn_connection_routes)
  destination_cidr_block = var.oci_ipsec_vpn_connection_routes[count.index]
  vpn_connection_id      = aws_vpn_connection.ipsec_vpn_connection.id

  depends_on = [
    aws_vpn_connection.ipsec_vpn_connection
  ]
}
resource "aws_route" "private_subnets_vpn_routes" {
  for_each = length(var.oci_ipsec_vpn_connection_routes) == 0 ? {} : {
    for pair in setproduct(
      data.aws_route_tables.private_subnet_route_tables.ids,
      var.oci_ipsec_vpn_connection_routes
    ) : "route-entry.${pair[0]}.${pair[1]}" => { rt_id = pair[0], dest_cidr = pair[1] }
  }
  route_table_id         = each.value.rt_id
  destination_cidr_block = each.value.dest_cidr
  gateway_id             = aws_vpn_gateway.ipsec_vpn_gateway.id
}

resource "aws_route" "private_cross_account_subnets_vpn_routes" {
  for_each = length(var.oci_ipsec_vpn_connection_routes) == 0 ? {} : {
    for pair in setproduct(
      values(module.cross_account_eks_access.az_route_table_ids),
      var.oci_ipsec_vpn_connection_routes
    ) : "route-entry.${pair[0]}.${pair[1]}" => { rt_id = pair[0], dest_cidr = pair[1] }
  }
  route_table_id         = each.value.rt_id
  destination_cidr_block = each.value.dest_cidr
  gateway_id             = aws_vpn_gateway.ipsec_vpn_gateway.id
}

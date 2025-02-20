locals {
  ipsec_tunnels_details = [
    {
      customer_interface_ip = var.oci_vpn_ipsec_tunnel_1_inside_ip_customer_g
      oracle_interface_ip   = var.oci_vpn_ipsec_tunnel_1_inside_ip_virtual_g
      customer_bgp_asn      = "65519"
      oracle_bgp_asn        = "31898"
    },
    {
      customer_interface_ip = var.oci_vpn_ipsec_tunnel_2_inside_ip_customer_g
      oracle_interface_ip   = var.oci_vpn_ipsec_tunnel_2_inside_ip_virtual_g
      customer_bgp_asn      = "65519"
      oracle_bgp_asn        = "31898"
    }
  ]
}

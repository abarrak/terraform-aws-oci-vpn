resource "oci_core_cpe" "oci_vpn_cpe" {
  compartment_id = var.compartment_id
  ip_address     = var.oci_vpn_ipsec_cpe_ip_address

  cpe_device_shape_id = data.oci_core_cpe_device_shapes.oci_cpe_shapes.cpe_device_shapes[5].cpe_device_shape_id
  display_name        = var.oci_vpn_ipsec_cpe_name
  is_private          = false

  defined_tags  = {}
  freeform_tags = local.tags
}

resource "oci_core_ipsec" "oci_vpn_ipsec_connection" {
  compartment_id = var.compartment_id
  cpe_id         = oci_core_cpe.oci_vpn_cpe.id
  drg_id         = data.oci_core_drgs.hub_drg.drgs[0].id
  static_routes  = var.oci_vpn_ipsec_vpn_connection_routes

  display_name              = var.oci_vpn_ipsec_connection_name
  cpe_local_identifier      = var.oci_vpn_ipsec_cpe_ip_address
  cpe_local_identifier_type = "IP_ADDRESS"

  defined_tags  = {}
  freeform_tags = local.tags
}

resource "oci_core_ipsec_connection_tunnel_management" "oci_vpn_ipsec_connection_tunnel" {
  count = var.oci_vpn_tunnels_management_supported ? length(local.ipsec_tunnels_details) : 0

  ipsec_id     = oci_core_ipsec.oci_vpn_ipsec_connection.id
  tunnel_id    = data.oci_core_ipsec_connection_tunnels.oci_vpn_tunnels[0].ip_sec_connection_tunnels[count.index].id
  routing      = "STATIC"

  display_name = "${var.oci_vpn_ipsec_connection_name} - ${count.index + 1}"

  nat_translation_enabled = "ENABLED"
  ike_version             = "V2"
  oracle_can_initiate     = "INITIATOR_OR_RESPONDER"
  shared_secret           = random_password.ipsec_shared_secret.result

  bgp_session_info {
    customer_bgp_asn      = local.ipsec_tunnels_details[count.index].customer_bgp_asn
    customer_interface_ip = local.ipsec_tunnels_details[count.index].customer_interface_ip
    oracle_interface_ip   = local.ipsec_tunnels_details[count.index].oracle_interface_ip
  }

  phase_one_details {
    is_custom_phase_one_config      = true
    custom_authentication_algorithm = var.oci_vpn_ipsec_authentication_phase_one_algorithm
    custom_encryption_algorithm     = var.oci_vpn_ipsec_encryption_algorithm
    custom_dh_group                 = var.oci_vpn_ipsec_dh_group
    lifetime                        = var.oci_vpn_ipsec_phase_one_lifetime
  }

  phase_two_details {
    is_custom_phase_two_config      = true
    custom_authentication_algorithm = var.oci_vpn_ipsec_authentication_phase_two_algorithm
    custom_encryption_algorithm     = var.oci_vpn_ipsec_encryption_algorithm
    dh_group                        = var.oci_vpn_ipsec_dh_group
    lifetime                        = var.oci_vpn_ipsec_phase_two_lifetime
    is_pfs_enabled                  = true
  }

  dpd_config {
    dpd_mode            = "INITIATE_AND_RESPOND"
    dpd_timeout_in_sec  = "20"
  }

  depends_on = [
    oci_core_ipsec.oci_vpn_ipsec_connection,
    data.oci_core_ipsec_connection_tunnels.oci_vpn_tunnels
  ]
}

resource "oci_core_drg_attachment" "oci_vpn_ipsec_attachments" {
  count              = length(local.ipsec_tunnels_details)
  drg_id             = data.oci_core_drgs.hub_drg.drgs[0].id
  drg_route_table_id = data.oci_core_drg_route_tables.drg_hub_route_tables.drg_route_tables[2].id
  display_name       = "DRG Attachment for tunnel: ${var.oci_vpn_ipsec_connection_name} #${count.index + 1}"

  defined_tags  = {}
  freeform_tags = local.tags

  depends_on = [
    oci_core_ipsec.oci_vpn_ipsec_connection
  ]
}

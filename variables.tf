variable "aws_region" {
  description = "The account region."
  type        = string
}

variable "tenancy_id" {
  description = "The OCID of tenancy."
  type        = string
}

variable "compartment_id" {
  description = "The OCID of compartment to provison resources in (except tenancy-level resources)."
  type        = string
}

variable "tags" {
  description = "(Optional) tags to attach to the provisioned resources."
  type        = map(any)
}


variable "aws_ipsec_gateway_cpe_name" {
  type        = string
  description = "(Required) the name for the aws customer gateway for the aws cpe."
  default     = "aws-to-oci-cpe"
}

variable "aws_ipsec_gateway_cpe_ip" {
  type        = string
  description = "(Required) the public IP for aws customer gateway. This is provided from the counterpart created in oci."
}

variable "aws_ipsec_vpn_gateway_name" {
  type        = string
  description = "(Required) the name for the aws vpn gateway."
  default     = "aws-vpn-virtual-gateway"
}

variable "aws_ipsec_vpn_connection_name" {
  type        = string
  description = "(Required) the name for aws vpn connection."
  default     = "AWS-To-OCI-Connection"
}

variable "aws_ipsec_vpn_connection_routes" {
  type        = list(string)
  description = "List of one or more static route between a VPN connection and a customer gateway."
  default     = []
}

variable "aws_ipsec_vpn_connection_tunnel_encryption_algorithms" {
  type        = list(string)
  description = "(Optional) List of one or more encryption algorithms that are permitted for the VPN tunnel's IKE negotiations."
  default     = ["AES256"]
}

variable "aws_ipsec_vpn_connection_tunnel_integrity_algorithms" {
  type        = list(string)
  description = "(Optional) List of one or more encryption algorithms that are permitted for the VPN tunnel's IKE negotiations."
  default     = ["SHA2-256"]
}

variable "aws_ipsec_vpn_connection_tunnel_dh_group_numbers" {
  type        = list(string)
  description = "(Optional) List of one or more Diffie-Hellman group numbers that are permitted for the VPN tunnel's IKE negotiations."
  default     = [14]
}

variable "hub_compartment_id" {
  description = "Compartment OCID for the DRG."
  type        = string
}


variable "oci_vpn_ipsec_cpe_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable."
  type        = string
  default     = "OCI-to-AWS-CPE"
}

variable "oci_vpn_ipsec_cpe_ip_address" {
  description = "(Required) the public IP for oci customer gateway. This is provided from the counterpart created in aws."
  type        = string
}

variable "oci_vpn_ipsec_connection_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
}

variable "oci_vpn_ipsec_vpn_connection_routes" {
  type        = list(string)
  description = "List of one or more static route between a VPN connection and a customer gateway."
  default     = []
}

variable "oci_vpn_ipsec_authentication_phase_one_algorithm" {
  description = "(Optional) The proposed custom authentication algorithm."
  type        = string
  default     = "SHA2_256"
}

variable "oci_vpn_ipsec_authentication_phase_two_algorithm" {
  description = "(Optional) The proposed custom authentication algorithm."
  type        = string
  default     = "HMAC_SHA2_256_128"
}

variable "oci_vpn_ipsec_encryption_algorithm" {
  description = "(Optional) The proposed custom encryption algorithm.."
  type        = string
  default     = "AES_256_CBC"
}

variable "oci_vpn_ipsec_dh_group" {
  description = "(Optional) The proposed Diffie-Hellman group."
  type        = string
  default     = "GROUP14"
}

variable "oci_vpn_ipsec_phase_one_lifetime" {
  description = "(Optional) The total configured lifetime of the IKE security association."
  type        = number
  default     = "28800"
}

variable "oci_vpn_ipsec_phase_two_lifetime" {
  description = "(Optional) The total configured lifetime of the IKE security association."
  type        = number
  default     = 3600
}

variable "oci_vpn_tunnels_management_supported" {
  description = "Decides whether tunnel import is enabled."
  type        = bool
  default     = false
}

variable "oci_vpn_ipsec_tunnel_1_inside_ip_customer_g" {
  description = "(Required) the inside IP address #1 for the Customer Gateway from AWS VPN."
  type        = string
}

variable "oci_vpn_ipsec_tunnel_1_inside_ip_virtual_g" {
  description = "(Required) Virtual Private Gateway inside IP address #1 from AWS VPN."
  type        = string
}

variable "oci_vpn_ipsec_tunnel_2_inside_ip_customer_g" {
  description = "(Required) the inside IP address #2 for the Customer Gateway from AWS VPN."
  type        = string
}

variable "oci_vpn_ipsec_tunnel_2_inside_ip_virtual_g" {
  description = "(Required) Virtual Private Gateway inside IP address #2 from the AWS VPN."
  type        = string
}

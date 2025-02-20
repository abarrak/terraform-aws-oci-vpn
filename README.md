<!-- BEGIN_TF_DOCS -->
# Terraform AWS and OCI VPN Module

[![Lints](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/format.yml/badge.svg)](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/format.yml) [![Docs](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/docs.yml/badge.svg)](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/docs.yml) [![Security](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/security.yml/badge.svg)](https://github.com/abarrak/terraform-aws-oci-vpn/actions/workflows/security.yml)

This module provides ability to provising IPSec VPN connection between AWS and Oracle (oci) clouds.

## Connectivity Notes

The modules should be provision in 2 phases order to provision each side per the documentation, including temporary CPE in the beginning. Suggested Order:
<blockquote>
1. main.tf <br>
2. aws.tf <br>
3. oci.tf <br>
</blockquote>

Additionally, to established HA setup the cpe resources creation step can be repeated.

## Usage

```hcl
module "aws-oci-vpn" {
  source  = "abarrak/oci-vpn/aws"
  version = "1.0.0"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.22 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 5.9.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.22 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 5.9.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route_tables.private_subnet_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [oci_core_cpe_device_shapes.oci_cpe_shapes](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_cpe_device_shapes) | data source |
| [oci_core_drg_route_tables.drg_hub_route_tables](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_drg_route_tables) | data source |
| [oci_core_drgs.hub_drg](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_drgs) | data source |
| [oci_core_ipsec_connection_tunnels.oci_vpn_tunnels](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_ipsec_connection_tunnels) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ipsec_gateway_cpe_ip"></a> [aws\_ipsec\_gateway\_cpe\_ip](#input\_aws\_ipsec\_gateway\_cpe\_ip) | (Required) the public IP for aws customer gateway. This is provided from the counterpart created in oci. | `string` | n/a | yes |
| <a name="input_aws_ipsec_gateway_cpe_name"></a> [aws\_ipsec\_gateway\_cpe\_name](#input\_aws\_ipsec\_gateway\_cpe\_name) | (Required) the name for the aws customer gateway for the aws cpe. | `string` | `"aws-to-oci-cpe"` | no |
| <a name="input_aws_ipsec_vpn_connection_name"></a> [aws\_ipsec\_vpn\_connection\_name](#input\_aws\_ipsec\_vpn\_connection\_name) | (Required) the name for aws vpn connection. | `string` | `"AWS-To-OCI-Connection"` | no |
| <a name="input_aws_ipsec_vpn_connection_routes"></a> [aws\_ipsec\_vpn\_connection\_routes](#input\_aws\_ipsec\_vpn\_connection\_routes) | List of one or more static route between a VPN connection and a customer gateway. | `list(string)` | `[]` | no |
| <a name="input_aws_ipsec_vpn_connection_tunnel_dh_group_numbers"></a> [aws\_ipsec\_vpn\_connection\_tunnel\_dh\_group\_numbers](#input\_aws\_ipsec\_vpn\_connection\_tunnel\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the VPN tunnel's IKE negotiations. | `list(string)` | <pre>[<br/>  14<br/>]</pre> | no |
| <a name="input_aws_ipsec_vpn_connection_tunnel_encryption_algorithms"></a> [aws\_ipsec\_vpn\_connection\_tunnel\_encryption\_algorithms](#input\_aws\_ipsec\_vpn\_connection\_tunnel\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the VPN tunnel's IKE negotiations. | `list(string)` | <pre>[<br/>  "AES256"<br/>]</pre> | no |
| <a name="input_aws_ipsec_vpn_connection_tunnel_integrity_algorithms"></a> [aws\_ipsec\_vpn\_connection\_tunnel\_integrity\_algorithms](#input\_aws\_ipsec\_vpn\_connection\_tunnel\_integrity\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the VPN tunnel's IKE negotiations. | `list(string)` | <pre>[<br/>  "SHA2-256"<br/>]</pre> | no |
| <a name="input_aws_ipsec_vpn_gateway_name"></a> [aws\_ipsec\_vpn\_gateway\_name](#input\_aws\_ipsec\_vpn\_gateway\_name) | (Required) the name for the aws vpn gateway. | `string` | `"aws-vpn-virtual-gateway"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The account region. | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of compartment to provison resources in (except tenancy-level resources). | `string` | n/a | yes |
| <a name="input_hub_compartment_id"></a> [hub\_compartment\_id](#input\_hub\_compartment\_id) | Compartment OCID for the DRG. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_authentication_phase_one_algorithm"></a> [oci\_vpn\_ipsec\_authentication\_phase\_one\_algorithm](#input\_oci\_vpn\_ipsec\_authentication\_phase\_one\_algorithm) | (Optional) The proposed custom authentication algorithm. | `string` | `"SHA2_256"` | no |
| <a name="input_oci_vpn_ipsec_authentication_phase_two_algorithm"></a> [oci\_vpn\_ipsec\_authentication\_phase\_two\_algorithm](#input\_oci\_vpn\_ipsec\_authentication\_phase\_two\_algorithm) | (Optional) The proposed custom authentication algorithm. | `string` | `"HMAC_SHA2_256_128"` | no |
| <a name="input_oci_vpn_ipsec_connection_name"></a> [oci\_vpn\_ipsec\_connection\_name](#input\_oci\_vpn\_ipsec\_connection\_name) | (Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_cpe_ip_address"></a> [oci\_vpn\_ipsec\_cpe\_ip\_address](#input\_oci\_vpn\_ipsec\_cpe\_ip\_address) | (Required) the public IP for oci customer gateway. This is provided from the counterpart created in aws. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_cpe_name"></a> [oci\_vpn\_ipsec\_cpe\_name](#input\_oci\_vpn\_ipsec\_cpe\_name) | (Optional) A user-friendly name. Does not have to be unique, and it's changeable. | `string` | `"OCI-to-AWS-CPE"` | no |
| <a name="input_oci_vpn_ipsec_dh_group"></a> [oci\_vpn\_ipsec\_dh\_group](#input\_oci\_vpn\_ipsec\_dh\_group) | (Optional) The proposed Diffie-Hellman group. | `string` | `"GROUP14"` | no |
| <a name="input_oci_vpn_ipsec_encryption_algorithm"></a> [oci\_vpn\_ipsec\_encryption\_algorithm](#input\_oci\_vpn\_ipsec\_encryption\_algorithm) | (Optional) The proposed custom encryption algorithm.. | `string` | `"AES_256_CBC"` | no |
| <a name="input_oci_vpn_ipsec_phase_one_lifetime"></a> [oci\_vpn\_ipsec\_phase\_one\_lifetime](#input\_oci\_vpn\_ipsec\_phase\_one\_lifetime) | (Optional) The total configured lifetime of the IKE security association. | `number` | `"28800"` | no |
| <a name="input_oci_vpn_ipsec_phase_two_lifetime"></a> [oci\_vpn\_ipsec\_phase\_two\_lifetime](#input\_oci\_vpn\_ipsec\_phase\_two\_lifetime) | (Optional) The total configured lifetime of the IKE security association. | `number` | `3600` | no |
| <a name="input_oci_vpn_ipsec_tunnel_1_inside_ip_customer_g"></a> [oci\_vpn\_ipsec\_tunnel\_1\_inside\_ip\_customer\_g](#input\_oci\_vpn\_ipsec\_tunnel\_1\_inside\_ip\_customer\_g) | (Required) the inside IP address #1 for the Customer Gateway from AWS VPN. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_tunnel_1_inside_ip_virtual_g"></a> [oci\_vpn\_ipsec\_tunnel\_1\_inside\_ip\_virtual\_g](#input\_oci\_vpn\_ipsec\_tunnel\_1\_inside\_ip\_virtual\_g) | (Required) Virtual Private Gateway inside IP address #1 from AWS VPN. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_tunnel_2_inside_ip_customer_g"></a> [oci\_vpn\_ipsec\_tunnel\_2\_inside\_ip\_customer\_g](#input\_oci\_vpn\_ipsec\_tunnel\_2\_inside\_ip\_customer\_g) | (Required) the inside IP address #2 for the Customer Gateway from AWS VPN. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_tunnel_2_inside_ip_virtual_g"></a> [oci\_vpn\_ipsec\_tunnel\_2\_inside\_ip\_virtual\_g](#input\_oci\_vpn\_ipsec\_tunnel\_2\_inside\_ip\_virtual\_g) | (Required) Virtual Private Gateway inside IP address #2 from the AWS VPN. | `string` | n/a | yes |
| <a name="input_oci_vpn_ipsec_vpn_connection_routes"></a> [oci\_vpn\_ipsec\_vpn\_connection\_routes](#input\_oci\_vpn\_ipsec\_vpn\_connection\_routes) | List of one or more static route between a VPN connection and a customer gateway. | `list(string)` | `[]` | no |
| <a name="input_oci_vpn_tunnels_management_supported"></a> [oci\_vpn\_tunnels\_management\_supported](#input\_oci\_vpn\_tunnels\_management\_supported) | Decides whether tunnel import is enabled. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) tags to attach to the provisioned resources. | `map(any)` | n/a | yes |
| <a name="input_tenancy_id"></a> [tenancy\_id](#input\_tenancy\_id) | The OCID of tenancy. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipsec_initial_cpe_arn"></a> [ipsec\_initial\_cpe\_arn](#output\_ipsec\_initial\_cpe\_arn) | The amazon resource name (arn) of the vpn customer gateway. |
| <a name="output_ipsec_shared_secret"></a> [ipsec\_shared\_secret](#output\_ipsec\_shared\_secret) | The IPSec connection shared secret. |
| <a name="output_ipsec_vpn_connection_id"></a> [ipsec\_vpn\_connection\_id](#output\_ipsec\_vpn\_connection\_id) | The ID for vpn connection resource. |
| <a name="output_ipsec_vpn_connection_tunnel_1_ip"></a> [ipsec\_vpn\_connection\_tunnel\_1\_ip](#output\_ipsec\_vpn\_connection\_tunnel\_1\_ip) | The public ip address of the first vpn tunnel. |
| <a name="output_ipsec_vpn_connection_tunnel_2_ip"></a> [ipsec\_vpn\_connection\_tunnel\_2\_ip](#output\_ipsec\_vpn\_connection\_tunnel\_2\_ip) | The public ip address of the second vpn tunnel |
| <a name="output_ipsec_vpn_gateway_arn"></a> [ipsec\_vpn\_gateway\_arn](#output\_ipsec\_vpn\_gateway\_arn) | The amazon resource name (arn) of the vpn gateway. |

# License

MIT.
<!-- END_TF_DOCS -->

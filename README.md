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
  source  = "abarrak/vpn/aws-oci-vpn"
  version = "1.0.0"
}
```


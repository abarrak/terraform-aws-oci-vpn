data "aws_vpc" "vpc" {
   filter {
     name = "tag:Name"
     values = [""]
   }
}

data "aws_route_tables" "private_subnet_route_tables" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [
      "${var.aws_region}a",
      "${var.aws_region}b",
      "${var.aws_region}c"]
  }
}


data "oci_core_drgs" "hub_drg" {
  compartment_id = var.hub_compartment_id
}

data "oci_core_drg_route_tables" "drg_hub_route_tables" {
  drg_id = data.oci_core_drgs.hub_drg.drgs[0].id
}

data "oci_core_ipsec_connection_tunnels" "aws_vpn_tunnels" {
  count    = var.aws_hub_tunnels_management_supported ? 1 : 0
  ipsec_id = oci_core_ipsec.aws_hub_ipsec_connection.id
}

data "oci_core_cpe_device_shapes" "oci_cpe_shapes" { }

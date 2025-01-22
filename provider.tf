terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">= 5.9.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.22"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
  required_version = "~> 1.3"
}

provider "aws" {
    region = var.aws_region
}

provider "oci" {
  tenancy_ocid = var.tenancy_id
}

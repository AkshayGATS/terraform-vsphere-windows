terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.3"
    }
  }

  required_version = ">= 1.0"
}

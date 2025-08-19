provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_template" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_compute_cluster.cluster.datastore_ids[0]

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_template.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_template.template.id

    customize {
      windows_options {
        computer_name  = var.vm_name
        admin_password = var.vsphere_password
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_subnet_mask
      }

      ipv4_gateway = var.vm_gateway
      dns_servers  = var.vm_dns
    }
  }
}

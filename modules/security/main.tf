terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 3.4.0"
    }
  }
}

resource "openstack_compute_instance_v2" "vm" {
  name            = var.name
  flavor_id       = var.flavor
  image_id        = var.image
  key_pair        = var.key_pair
  region          = var.region
  availability_zone = "nova"

  network {
    name       = var.networks[0].name
    fixed_ip_v4 = var.networks[0].ip
  }

  metadata = var.tags
  security_groups = ["default"]

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "15m"
    delete = "15m"
  }
}

data "openstack_networking_network_v2" "net" {
  for_each = { for idx, n in var.networks : idx => n if idx > 0 && n.enabled }
  name     = each.value.name
}

resource "openstack_compute_interface_attach_v2" "net_attach" {
  for_each = { for idx, n in var.networks : idx => n if idx > 0 && n.enabled }

  instance_id = openstack_compute_instance_v2.vm.id
  network_id  = data.openstack_networking_network_v2.net[each.key].id
  fixed_ip    = each.value.ip

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "10m"
    delete = "10m"
  }
}

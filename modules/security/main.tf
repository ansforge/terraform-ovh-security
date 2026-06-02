terraform {
  required_providers {
    openstack = { source = "terraform-provider-openstack/openstack" }
    tls       = { source = "hashicorp/tls" }
  }
}

# --- Clé SSH ---
resource "tls_private_key" "instance_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "openstack_compute_keypair_v2" "instance_kp" {
  name       = "key-${var.name}"
  public_key = tls_private_key.instance_key.public_key_openssh
  region     = var.region
}

# --- Lookup des réseaux ---
data "openstack_networking_network_v2" "networks" {
  for_each = { for n in var.networks : n.name => n if n.enabled }
  name     = each.key
  region   = var.region
}

# --- Création des ports (découplés de l'instance) ---
resource "openstack_networking_port_v2" "ports" {
  for_each   = { for n in var.networks : n.name => n if n.enabled }
  name       = "port-${var.name}-${each.key}"
  network_id = data.openstack_networking_network_v2.networks[each.key].id
  region     = var.region

  fixed_ip {
    ip_address = each.value.ip
  }

  port_security_enabled = false

  # Empêche la recréation du port si seulement l'IP change
  lifecycle {
    ignore_changes = [fixed_ip]
  }
}

# --- Instance (sans réseau inline) ---
# Le premier port est attaché via network_id pour le boot,
# les suivants via des attachments dynamiques
resource "openstack_compute_instance_v2" "fw" {
  name      = var.name
  flavor_id = var.flavor
  image_id  = var.image
  key_pair  = openstack_compute_keypair_v2.instance_kp.name
  region    = var.region

  # On attache uniquement le premier port au boot (nécessaire pour le démarrage)
  network {
    port = openstack_networking_port_v2.ports[local.ordered_networks[0]].id
  }

  metadata = var.tags

  lifecycle {
    # Ignore les changements de réseau inline → gérés par les attachments
    ignore_changes = [network]
  }
}

# --- Ordre déterministe des réseaux ---
locals {
  ordered_networks = sort([
    for n in var.networks : n.name if n.enabled
  ])
}

# --- Attachments dynamiques pour tous les ports sauf le premier ---
resource "openstack_compute_interface_attach_v2" "attachments" {
  for_each    = toset(slice(local.ordered_networks, 1, length(local.ordered_networks)))
  instance_id = openstack_compute_instance_v2.fw.id
  port_id     = openstack_networking_port_v2.ports[each.value].id
  region      = var.region
}

# --- terraform-ovh-security/main.tf ---

terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = ">= 2.11.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 3.4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.2.0"
    }
  }
}

provider "ovh" {
  endpoint = "ovh-eu"
  # Ajoutez les credentials ici si nécessaire, ou via var.
}

provider "openstack" {
  auth_url                        = var.os_auth_url
  application_credential_id       = var.os_user
  application_credential_secret   = var.os_password
  region                          = var.region
}

resource "tls_private_key" "vm_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "openstack_compute_keypair_v2" "vm_key" {
  name       = "vm-fwfe-key"
  public_key = tls_private_key.vm_ssh_key.public_key_openssh
}

# --- MODIFICATION ICI : La source pointe vers le dossier local ---
module "vm_stormshield_fwfe" {
  source = "git::https://github.com/ansforge/terraform-ovh-security.git//modules/security?ref=amont"

  # Variables de connexion requises par le module
  os_auth_url = var.os_auth_url
  os_user     = var.os_user
  os_password = var.os_password
  region      = var.region

  name     = var.name
  flavor   = var.flavor
  image    = var.image
  key_pair = openstack_compute_keypair_v2.vm_key.name

  networks = var.networks
  tags     = var.tags
}

output "private_key" {
  value     = tls_private_key.vm_ssh_key.private_key_pem
  sensitive = true
}

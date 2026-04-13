terraform {
  required_providers {
    ovh       = { source = "ovh/ovh", version = ">= 0.40.0" }
    openstack = { source = "terraform-provider-openstack/openstack", version = ">= 1.53.0" }
    vault     = { source = "hashicorp/vault", version = ">= 3.25.0" }
  }
}

# --- Provider Vault ---
provider "vault" {
  skip_child_token = true
}

# --- Récupération des credentials OpenStack depuis Vault ---
ephemeral "vault_kv_secret_v2" "os" {
  mount = "iacrunner-outils"
  name  = "openstack_key"
}

locals {
  os_creds = ephemeral.vault_kv_secret_v2.os.data
}

# --- Provider OpenStack ---
provider "openstack" {
  auth_url                      = local.os_creds["OS_AUTH_URL"]
  application_credential_id     = local.os_creds["OS_APPLICATION_CREDENTIAL_ID"]
  application_credential_secret = local.os_creds["OS_APPLICATION_CREDENTIAL_SECRET"]
  region                        = var.region
}

# --- Module Stormshield (firewalls) ---
module "stormshield_cluster" {
  source   = "./modules/security"
  for_each = var.firewalls

  name     = each.value.name
  flavor   = each.value.flavor
  image    = each.value.image
  region   = var.region
  networks = each.value.networks
  tags     = each.value.tags
}

# --- Module Wallix (bastion + access manager) ---
module "wallix_instances" {
  source   = "./modules/security"
  for_each = var.wallix

  name     = each.value.name
  flavor   = each.value.flavor
  image    = each.value.image
  region   = var.region
  networks = each.value.networks
  tags     = each.value.tags
}

# --- Outputs Firewalls ---
output "fw_private_keys" {
  value     = { for k, v in module.stormshield_cluster : k => v.private_key_pem }
  sensitive = true
}

output "fw_instance_ids" {
  value = { for k, v in module.stormshield_cluster : k => v.instance_id }
}

# --- Outputs Wallix ---
output "wallix_private_keys" {
  value     = { for k, v in module.wallix_instances : k => v.private_key_pem }
  sensitive = true
}

output "wallix_instance_ids" {
  value = { for k, v in module.wallix_instances : k => v.instance_id }
}

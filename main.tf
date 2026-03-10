# main.tf (Racine du projet terraform-ovh-security)

terraform {
  required_providers {
    ovh       = { source = "ovh/ovh", version = ">= 0.40.0" }
    openstack = { source = "terraform-provider-openstack/openstack", version = ">= 1.53.0" }
    vault     = { source = "hashicorp/vault", version = ">= 3.25.0" }
  }
}

# --- Configuration Vault ---
provider "vault" {
  # L'adresse de Vault est généralement récupérée via la variable d'env VAULT_ADDR
  skip_child_token = true
}

# Récupération des credentials OpenStack depuis Vault
ephemeral "vault_kv_secret_v2" "os" {
  mount = "iacrunner-prod"
  name  = "openstack_key"
}

locals {
  os_creds = ephemeral.vault_kv_secret_v2.os.data
}

# --- Configuration du Provider OpenStack ---
provider "openstack" {
  auth_url                      = local.os_creds["OS_AUTH_URL"]
  application_credential_id     = local.os_creds["OS_APPLICATION_CREDENTIAL_ID"]
  application_credential_secret = local.os_creds["OS_APPLICATION_CREDENTIAL_SECRET"]
  region                        = var.region
}

# --- Appel du Module Security ---
# Ce module gère la génération des clés SSH, les ports réseaux et l'instance Stormshield
module "stormshield_cluster" {
  source   = "./modules/security"
  for_each = var.firewalls

  name     = each.value.name
  flavor   = each.value.flavor
  image    = each.value.image
  region   = var.region
  networks = each.value.networks
  tags     = each.value.tags

  # Note : Les variables os_user, os_password et key_pair ont été retirées 
  # car elles sont gérées soit par le provider global, soit en interne par le module.
}

# --- Outputs ---
# Récupération des clés privées générées dynamiquement pour chaque firewall
output "fw_private_keys" {
  value     = { for k, v in module.stormshield_cluster : k => v.private_key_pem }
  sensitive = true
}

output "fw_instance_ids" {
  value = { for k, v in module.stormshield_cluster : k => v.instance_id }
}

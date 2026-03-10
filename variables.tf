# variables.tf (Racine du projet terraform-ovh-security)

# --- Configuration Globale ---
variable "region" {
  type        = string
  description = "Région OVH Public Cloud (ex: RBX-A, GRA11)"
}

# --- Définition du Cluster de Firewalls ---
# Cette variable remplace les anciennes variables individuelles (flavor, image, etc.)
variable "firewalls" {
  description = "Map des instances Stormshield à créer"
  type = map(object({
    name   = string
    flavor = string
    image  = string
    networks = list(object({
      name    = string
      ip      = string
      enabled = bool
    }))
    tags = map(string)
  }))
}

# --- Variables optionnelles ou pour compatibilité interne ---
variable "user_name" {
  type    = string
  default = ""
}

variable "os_project_name" {
  type    = string
  default = ""
}

variable "os_domain" {
  type    = string
  default = ""
}

# Note : Les variables os_auth_url, os_user, os_password sont supprimées 
# car nous utilisons maintenant Vault (ephemeral block) dans le main.tf

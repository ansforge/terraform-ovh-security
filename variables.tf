# --- Variables de connexion ---
variable "os_auth_url" { type = string }
variable "os_user" { type = string }
variable "os_password" { type = string }
variable "region" { type = string }

# --- Variables VM ---
variable "name" { type = string }
variable "flavor" { type = string }
variable "image" { type = string }
variable "key_pair" { type = string }
variable "tags" { type = map(string) }

# --- Variable Réseaux ---
variable "networks" {
  description = "Liste des réseaux avec nom, ip et statut enabled"
  type = list(object({
    name    = string
    ip      = string
    enabled = bool
  }))
}

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

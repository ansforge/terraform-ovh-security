variable "name" {
  type        = string
  description = "Nom de l'instance"
}

variable "flavor" {
  type        = string
  description = "ID du flavor OpenStack"
}

variable "image" {
  type        = string
  description = "ID de l'image OpenStack"
}

variable "region" {
  type        = string
  description = "Région OpenStack"
}

variable "networks" {
  type = list(object({
    name    = string
    ip      = string
    enabled = bool
  }))
  description = "Liste des interfaces réseau"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Métadonnées de l'instance"
}

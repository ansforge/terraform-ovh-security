variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "flavor" {
  type = string
}

variable "image" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "networks" {
  description = "Liste des réseaux avec ip et enabled"
  type = list(object({
    name    = string
    ip      = string
    enabled = bool
  }))
}

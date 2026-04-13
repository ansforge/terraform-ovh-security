variable "region" {
  type = string
}

variable "firewalls" {
  type = map(object({
    name     = string
    flavor   = string
    image    = string
    networks = list(any)
    tags     = map(string)
  }))
}

variable "wallix" {
  type = map(object({
    name     = string
    flavor   = string
    image    = string
    networks = list(any)
    tags     = map(string)
  }))
  default = {}
}

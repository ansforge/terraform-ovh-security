region = "RBX-A"

firewalls = {
  # --- Stormshield Master (fwfe01) ---
  "fwfe01" = {
    name   = "infra-prod-fwfe01"
    flavor = "58a6c33c-8c3d-4a94-8d03-2153139832b8"
    image  = "042e000e-55b0-4c3c-8398-60d853d886f5"

    networks = [
      { name = "prod-production-fwfe-ha-172.16.21.32-28",    ip = "172.16.21.45", enabled = true },
      { name = "prod-production-app-front-10.13.0.0-24",    ip = "10.13.0.251",  enabled = true },
      { name = "prod-production-k8s-front-10.11.60.0-24",   ip = "10.11.60.251", enabled = true },
      { name = "prod-production-dmz-transit-10.11.70.0-24",  ip = "10.11.70.251", enabled = true },
      { name = "prod-production-dmz-exposed-10.11.30.0-24",  ip = "10.11.30.251", enabled = true },
      { name = "prod-production-fwfe-admin-10.11.20.0-24",   ip = "10.11.20.251", enabled = true },
      { name = "prod-production-fw-interco-172.16.21.16-28", ip = "172.16.21.29",  enabled = true },
      { name = "prod-production-vrack-vpn-10.11.10.0-24",    ip = "10.11.10.251", enabled = true }
    ]

    tags = { Owner = "infra-team", Env = "prod", Role = "master" }
  },

  # --- Stormshield Slave (fwfe02) ---
  "fwfe02" = {
    name   = "infra-prod-fwfe02"
    flavor = "58a6c33c-8c3d-4a94-8d03-2153139832b8"
    image  = "042e000e-55b0-4c3c-8398-60d853d886f5"

    networks = [
      { name = "prod-production-fwfe-ha-172.16.21.32-28",    ip = "172.16.21.44", enabled = true },
      { name = "prod-production-app-front-10.13.0.0-24",    ip = "10.13.0.252",  enabled = true },
      { name = "prod-production-k8s-front-10.11.60.0-24",   ip = "10.11.60.252", enabled = true },
      { name = "prod-production-dmz-transit-10.11.70.0-24",  ip = "10.11.70.252", enabled = true },
      { name = "prod-production-dmz-exposed-10.11.30.0-24",  ip = "10.11.30.252", enabled = true },
      { name = "prod-production-fwfe-admin-10.11.20.0-24",   ip = "10.11.20.252", enabled = true },
      { name = "prod-production-fw-interco-172.16.21.16-28", ip = "172.16.21.28",  enabled = true },
      { name = "prod-production-vrack-vpn-10.11.10.0-24",    ip = "10.11.10.252", enabled = true }
    ]

    tags = { Owner = "infra-team", Env = "prod", Role = "slave" }
  }
}

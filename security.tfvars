region = "RBX-A"

firewalls = {
  # --- Stormshield Master ---
  "fwfe01" = {
    name   = "infra-prod-fwfe01"
    flavor = "58a6c33c-8c3d-4a94-8d03-2153139832b8"
    image  = "042e000e-55b0-4c3c-8398-60d853d886f5"

    networks = [
      { name = "prod-production-fwfe-front-10.11.0.0-24",   ip = "10.11.0.254", enabled = true },
      { name = "prod-production-infra-admin-10.11.51.0-24", ip = "10.11.51.1",  enabled = true },
      { name = "prod-production-infra-app-10.11.90.0-24",   ip = "10.11.90.1",  enabled = true },
      { name = "prod-production-app-front-10.13.0.0-24",    ip = "10.13.0.1",   enabled = true },
      { name = "prod-production-app-middle-10.13.1.0-24",   ip = "10.13.1.1",   enabled = true },
      { name = "prod-production-app-back-10.13.2.0-24",     ip = "10.13.2.1",   enabled = true },
      { name = "prod-production-k8s-front-10.11.60.0-24",   ip = "10.11.60.1",  enabled = true },
      { name = "prod-production-k8s-back-10.11.61.0-24",    ip = "10.11.61.1",  enabled = true },
      { name = "prod-production-dmz-admin-10.11.52.0-24",    ip = "10.11.52.1",  enabled = true },
      { name = "prod-production-dmz-transit-10.11.70.0-24",  ip = "10.11.70.1",  enabled = true },
      { name = "prod-production-dmz-exposed-10.11.30.0-24",  ip = "10.11.30.1",  enabled = true },
      { name = "prod-production-fwfe-admin-10.11.20.0-24",   ip = "10.11.20.1",  enabled = true },
      { name = "prod-production-fw-interco-10.11.40.0-24",   ip = "10.11.40.1",  enabled = true },
      { name = "prod-production-vrack-vpn-10.11.10.0-24",    ip = "10.11.10.1",  enabled = true }
    ]

    tags = { Owner = "infra-team", Env = "prod", Role = "master" }
  },

  # --- Stormshield Slave ---
  "fwfe02" = {
    name   = "infra-prod-fwfe02"
    flavor = "58a6c33c-8c3d-4a94-8d03-2153139832b8"
    image  = "042e000e-55b0-4c3c-8398-60d853d886f5"

    networks = [
      { name = "prod-production-fwfe-front-10.11.0.0-24",   ip = "10.11.0.253", enabled = true },
      { name = "prod-production-infra-admin-10.11.51.0-24", ip = "10.11.51.2",  enabled = true },
      { name = "prod-production-infra-app-10.11.90.0-24",   ip = "10.11.90.2",  enabled = true },
      { name = "prod-production-app-front-10.13.0.0-24",    ip = "10.13.0.2",   enabled = true },
      { name = "prod-production-app-middle-10.13.1.0-24",   ip = "10.13.1.2",   enabled = true },
      { name = "prod-production-app-back-10.13.2.0-24",     ip = "10.13.2.2",   enabled = true },
      { name = "prod-production-k8s-front-10.11.60.0-24",   ip = "10.11.60.2",  enabled = true },
      { name = "prod-production-k8s-back-10.11.61.0-24",    ip = "10.11.61.2",  enabled = true },
      { name = "prod-production-dmz-admin-10.11.52.0-24",    ip = "10.11.52.2",  enabled = true },
      { name = "prod-production-dmz-transit-10.11.70.0-24",  ip = "10.11.70.2",  enabled = true },
      { name = "prod-production-dmz-exposed-10.11.30.0-24",  ip = "10.11.30.2",  enabled = true },
      { name = "prod-production-fwfe-admin-10.11.20.0-24",   ip = "10.11.20.2",  enabled = true },
      { name = "prod-production-fw-interco-10.11.40.0-24",   ip = "10.11.40.2",  enabled = true },
      { name = "prod-production-vrack-vpn-10.11.10.0-24",    ip = "10.11.10.2",  enabled = true }
    ]

    tags = { Owner = "infra-team", Env = "prod", Role = "slave" }
  }
}

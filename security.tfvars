region = "SBG5"

firewalls = {
  "fwfe01" = {
    name   = "infra-amont-fwfe01"
    flavor = "acb62e0d-fa78-4a09-8e08-ba2e30fb4ff9"
    image  = "9ba60c29-ea48-419a-bb2a-f65f4f2cef62"

    networks = [
      { name = "preprod-amont-fwfe-front-10.12.0.0-24",    ip = "10.12.0.251",  enabled = true },
      { name = "preprod-amont-fwfe-admin-10.12.20.0-24",   ip = "10.12.20.251", enabled = true },
      { name = "preprod-amont-dmz-exposed-10.12.30.0-24",  ip = "10.12.30.251", enabled = true },
      { name = "preprod-amont-dmz-transit-10.12.70.0-24",  ip = "10.12.70.251", enabled = true },
      { name = "preprod-amont-infra-app-10.12.90.0-24",    ip = "10.12.90.251", enabled = true },
      { name = "preprod-amont-k8s-front-10.12.60.0-24",    ip = "10.12.60.251", enabled = true },
      { name = "preprod-amont-vrack-vpn-10.12.10.0-24",    ip = "10.12.10.251", enabled = true },

      # Interco /28 (plage: .17 → .30)
      { name = "preprod-amont-fw-interco-172.16.31.16-28", ip = "172.16.31.29", enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "amont"
      Role  = "master"
    }
  }
}

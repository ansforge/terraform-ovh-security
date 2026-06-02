region = "SBG5"

firewalls = {
  "fwfe01" = {
    name   = "infra-amont-fwfe01"
    flavor = "acb62e0d-fa78-4a09-8e08-ba2e30fb4ff9"
    image  = "9ba60c29-ea48-419a-bb2a-f65f4f2cef62"

    networks = [
      { name = "preprod-amont-app-front-10.14.0.0-24",    ip = "10.14.0.254",  enabled = true },
      { name = "preprod-amont-k8s-front-10.12.60.0-24",   ip = "10.12.60.254", enabled = true },
      { name = "preprod-amont-dmz-exposed-10.12.30.0-24",  ip = "10.12.30.254", enabled = true },
      { name = "preprod-amont-vrack-vpn-10.12.10.0-24",    ip = "10.12.10.254", enabled = true },
      { name = "preprod-amont-fw-interco-172.16.31.16-28", ip = "172.16.31.29",  enabled = true },
      { name = "preprod-amont-fwfe-admin-10.12.20.0-24",   ip = "10.12.20.254", enabled = true },
      { name = "preprod-amont-fw-front-5.196.116.80-28",   ip = "5.196.116.82",  enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "amont"
      Role  = "master"
    }
  }
}

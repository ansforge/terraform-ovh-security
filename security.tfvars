region = "EU-WEST-PAR"

firewalls = {
  "fwfe01" = {
    name   = "infra-outils-fwfe01"
    flavor = "e4943d80-10a3-461c-a4a2-2d17ea114fb0"
    image  = "333bc0fd-7067-4997-ae74-97f609f8d1bc"

    networks = [
      { name = "outils-fwfe-admin-10.15.20.0-24",   ip = "10.15.20.51",   enabled = true },
      { name = "outils-dmz-exposed-10.15.30.0-24",  ip = "10.15.30.251",  enabled = true },
      { name = "outils-fw-interco-172.16.26.16-28", ip = "172.16.26.25",   enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "outils"
      Role  = "firewall"
    }
  }
}

wallix = {
  "bastion01" = {
    name   = "infra-outils-bastion01"
    flavor = "e4943d80-10a3-461c-a4a2-2d17ea114fb0"
    image  = "29af1d91-b83b-469b-9a99-ebf66bbb7611"

    networks = [
      { name = "outils-infra-admin-10.16.51.0-24", ip = "10.16.51.52", enabled = true },
      { name = "outils-bastion-in-10.15.92.0-24",  ip = "10.16.92.52", enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "outils"
      Role  = "bastion"
    }
  }

  "bastion02" = {
    name   = "infra-outils-bastion02"
    flavor = "e4943d80-10a3-461c-a4a2-2d17ea114fb0"
    image  = "29af1d91-b83b-469b-9a99-ebf66bbb7611"

    networks = [
      { name = "outils-infra-admin-10.16.51.0-24", ip = "10.16.51.53", enabled = true },
      { name = "outils-bastion-in-10.15.92.0-24",  ip = "10.16.92.53", enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "outils"
      Role  = "bastion"
    }
  }

  "wabam01" = {
    name   = "infra-outils-wabam01"
    flavor = "e4943d80-10a3-461c-a4a2-2d17ea114fb0"
    image  = "48023a63-3722-40d1-9758-cc6d792e840f"

    networks = [
      { name = "outils-infra-admin-10.16.51.0-24", ip = "10.16.51.51", enabled = true },
      { name = "outils-bastion-in-10.15.92.0-24",  ip = "10.16.92.51", enabled = true }
    ]

    tags = {
      Owner = "infra-team"
      Env   = "outils"
      Role  = "access-manager"
    }
  }


  "opnsense01" = {
    name   = "infra-outils-opnsense01"
    flavor = "e4943d80-10a3-461c-a4a2-2d17ea114fb0"
    image  = "6b8be10a-b518-40a9-8883-8ac24c7f6861"

    networks = [
      { name = "outils-fw-interco-172.16.26.16-28",  ip = "172.16.26.24", enabled = true },
      { name = "outils-fwbe-admin-10.16.50.0-24",    ip = "10.16.50.254", enabled = true },
      { name = "outils-infra-admin-10.16.51.0-24",   ip = "10.16.51.254", enabled = true },
      { name = "outils-dmz-admin-10.16.52.0-24",     ip = "10.16.52.254", enabled = true },
      { name = "outils-k8s-10.16.61.0-24",           ip = "10.16.61.254", enabled = true },
      { name = "outils-dmz-transit-10.16.70.0-24",   ip = "10.16.70.254", enabled = true },
      { name = "outils-infra-app-10.16.90.0-24",     ip = "10.16.90.254", enabled = true },
      { name = "outils-bastion-in-10.15.92.0-24", ip = "10.16.92.254", enabled = true }

    ]

    tags = {
      Owner = "infra-team"
      Env   = "outils"
      Role  = "opnsense"
    }
  }
}

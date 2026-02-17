os_auth_url     = "https://auth.cloud.ovh.net/v3/"
os_project_name = "a5a3658023e146e78a22afd04601b813"
user_name       = "a817b4470bcd42b0af4dd9ab40c550df"
os_user         = "5322855a312548738bfcc487c3a17cdd"
os_password     = "quOw_e1ov11pyQrNbV_w-zAcA42zOq854kQac0I5Ct1DcvPhkeTh2aazqh8GJh8YHRzVeySXSMyb7IuImBaOXw"
os_domain       = "Default"
region          = "SBG5"
name            = "infra-amont-fwfe01"
flavor          = "acb62e0d-fa78-4a09-8e08-ba2e30fb4ff9"
image           = "9ba60c29-ea48-419a-bb2a-f65f4f2cef62"
key_pair        = "vm-fwfe-key"

networks = [
  { name = "fwfe-amont-admin-172.16.11.0-24", ip = "172.16.11.254", enabled = true },
  { name = "fw-amont-interco-172.16.21.0-24", ip = "172.16.21.254", enabled = true },
  { name = "fwfe-amont-front-172.16.31.0-24", ip = "172.16.31.254", enabled = true }, # désactivé
  { name = "fwfe-amont-tech-172.16.41.0-24", ip = "172.16.41.254", enabled = true },
  { name = "Gateway", ip = "192.168.5.3", enabled = false } # désactivé
]

tags = {
  Owner = "infra-team"
  Env   = "amont"
  App   = "stormshield"
  Lot   = "01"
}

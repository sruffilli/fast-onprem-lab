locals {
  vpn_config = { for v in var.vpn_config : v.name => v }
}

resource "hcloud_ssh_key" "default" {
  name       = "hetzner_key"
  public_key = file(var.ssh_key)
}

resource "hcloud_server" "vpngw" {
  for_each    = local.vpn_config
  name        = "vpngw-${each.key}"
  image       = "debian-11"
  server_type = "cpx11"
  location    = "fsn1"
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = templatefile(var.cloud_init_template, local.vpn_config[each.key])
}

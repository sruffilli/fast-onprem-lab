locals {
  cloud_config = {
    vpngw = templatefile(var.cloud_init_template, var.vpn_config)
  }
}

resource "hcloud_ssh_key" "default" {
  name       = "hetzner_key"
  public_key = file(var.ssh_key)
}

resource "hcloud_server" "vpngw" {
  name        = "vpngw"
  image       = "debian-11"
  server_type = "cpx11"
  location    = "fsn1"
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = local.cloud_config.vpngw
}

resource "hcloud_server_network" "vpngw_network" {
  server_id = hcloud_server.vpngw.id
  subnet_id = hcloud_network_subnet.vpngw.id
}

resource "hcloud_network" "vpngw" {
  name     = "net-vpngw"
  ip_range = "10.0.64.0/24"
}


resource "hcloud_network_subnet" "vpngw" {
  network_id   = hcloud_network.vpngw.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.64.0/24"
}

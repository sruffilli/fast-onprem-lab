locals {
  cloud_config = {
    fal = templatefile("cloud-init/vpngw-fal.yaml", var.vpn_config.fal)
  }
}

resource "hcloud_ssh_key" "default" {
  name       = "hetzner_key"
  public_key = file(var.ssh_key)
}

resource "hcloud_server" "fal" {
  name        = "vpngw"
  image       = "debian-11"
  server_type = "cpx11"
  location    = "fsn1"
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = local.cloud_config.fal
}

resource "hcloud_server_network" "fal_network" {
  server_id = hcloud_server.fal.id
  subnet_id = hcloud_network_subnet.fal.id
}

resource "hcloud_network" "fal" {
  name     = "net-fal"
  ip_range = "10.0.64.0/24"
}


resource "hcloud_network_subnet" "fal" {
  network_id   = hcloud_network.fal.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.64.0/24"
}

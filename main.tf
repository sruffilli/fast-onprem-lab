locals {
  vpn_config = yamldecode(file("class.yaml"))
}

module "hetzner" {
  source              = "./modules/hetzner-lab"
  cloud_init_template = "./cloud-init/vpngw.yaml"
  hetzner_token       = var.hetzner_token
  ssh_key             = var.ssh_key
  vpn_config          = local.vpn_config
}

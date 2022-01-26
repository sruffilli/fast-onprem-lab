output "ips" {
  value = {
    vpngw-public  = module.hetzner.ips.vpngw-public
    vpngw-private = module.hetzner.ips.vpngw-private
  }
}

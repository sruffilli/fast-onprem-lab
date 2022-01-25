output "ips" {
  value = {
    vpngw-fal-public  = hcloud_server.fal.ipv4_address
    vpngw-fal-private = hcloud_server_network.fal_network.ip
  }
}

output "ips" {
  value = {
    vpngw-public  = hcloud_server.vpngw.ipv4_address
    vpngw-private = hcloud_server_network.vpngw_network.ip
  }
}

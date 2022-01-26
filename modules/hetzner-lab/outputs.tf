output "ips" {
  value = {
    public  = hcloud_server.vpngw.ipv4_address
    private = hcloud_server_network.vpngw_network.ip
  }
}

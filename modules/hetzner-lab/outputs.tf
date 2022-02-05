output "ips" {
  value = { for index, server in hcloud_server.vpngw : index => server.ipv4_address }
}


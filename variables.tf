variable "ssh_key" {
  description = "Path to the SSH key that will be uploaded on the instance for remote access."
}

variable "hetzner_token" {
  description = "Hetzner API Token"
}

variable "vpn_config" {
  default = {
    fal = {
      remote_asn = 64512
      local_asn  = 65534
      peer1 = {
        local_bgp_address     = "169.254.1.1"
        peer_ip               = "35.242.81.74"
        peer_bgp_address      = "169.254.1.2"
        remote_ip_cidr_ranges = "10.128.0.0/9"
        shared_secret         = "foobar"
      }
      peer2 = {
        local_bgp_address     = "169.254.1.5"
        peer_ip               = "35.220.98.66"
        peer_bgp_address      = "169.254.1.6"
        remote_ip_cidr_ranges = "10.128.0.0/9"
        shared_secret         = "foobar"
      }
    }
  }
}

variable "hetzner_token" {
  description = "Hetzner API Token"
}

variable "ssh_key" {
  description = "Path to the SSH key that will be uploaded on the instance for remote access."
}

variable "vpn_config" {
  description = "VPN config data"
  type = object({
    remote_asn = string
    local_asn  = string
    peer1 = object({
      local_bgp_address     = string
      peer_ip               = string
      peer_bgp_address      = string
      remote_ip_cidr_ranges = string
      shared_secret         = string
    })
    peer2 = object({
      local_bgp_address     = string
      peer_ip               = string
      peer_bgp_address      = string
      remote_ip_cidr_ranges = string
      shared_secret         = string
    })
  })
  #  default = {
  #    remote_asn = "64512"
  #    local_asn  = "65534"
  #    peer1 = {
  #      local_bgp_address     = "169.254.1.1"
  #      peer_ip               = "35.242.81.74"
  #      peer_bgp_address      = "169.254.1.2"
  #      remote_ip_cidr_ranges = "10.128.0.0/9"
  #      shared_secret         = "foobar"
  #    }
  #    peer2 = {
  #      local_bgp_address     = "169.254.1.5"
  #      peer_ip               = "35.220.98.66"
  #      peer_bgp_address      = "169.254.1.6"
  #      remote_ip_cidr_ranges = "10.128.0.0/9"
  #      shared_secret         = "foobar"
  #    }
  #  }
}

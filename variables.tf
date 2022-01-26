variable "hetzner_token" {
  description = "Hetzner API Token"
}

variable "onprem_cidr" {
  description = "CIDR to use for the Hetzner VPC."
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
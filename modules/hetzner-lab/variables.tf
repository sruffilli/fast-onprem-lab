variable "cloud_init_template" {
  description = "Path to the cloud-init template"
  default     = "../cloud-init/vpngw.yaml"
}

variable "hetzner_token" {
  description = "Hetzner API Token"
}

variable "ssh_key" {
  description = "Path to the SSH key that will be uploaded on the instance for remote access."
}

variable "vpn_config" {
  description = "Configuration to init IPSec/BGP."
}

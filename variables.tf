variable "hetzner_token" {
  description = "Hetzner API Token"
}

variable "ssh_key" {
  description = "Path to the SSH key that will be uploaded on the instance for remote access."
  default     = "~/.ssh/id_rsa.pub"
}

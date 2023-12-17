resource "tls_private_key" "ad_master_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  admin_secret = templatefile(
    "templates/admin.secret.tftpl",
    {
      username       = var.admin_username
      ssh_public_key = tls_private_key.ad_master_key.public_key_openssh
    }
  )
}

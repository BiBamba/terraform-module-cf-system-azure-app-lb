# To convert the PEM certificate in PFX we need a password
resource "random_password" "pfx-password" {
  count = length(var.http_listeners)
  length = 24
  special = true
}

# one or more pem file
# This resource converts the PEM certicate in PFX
resource "pkcs12_from_pem" "certificates" {
  for_each = var.certificates
  cert_pem = each.value.cert_pem
  private_key_pem = each.value.private_key_pem
  password = random_password.pfx-password[count.index].result
}

/*
resource "pkcs12_from_pem" "dbe_certificate" {
  cert_pem = var.cert_pem01
  private_key_pem = var.private_key_pem01
  password = random_password.pfx-password.result
  #password = random_password.pfx-password[1].result
}
*/
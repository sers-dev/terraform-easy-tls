resource "tls_private_key" "caKey" {
  count = var.ca == null ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = var.rsaBits
}

resource "tls_self_signed_cert" "caCert" {
  count = var.ca == null ? 1 : 0

  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
    "digital_signature",
    "cert_signing"
  ]
  #key_algorithm         = tls_private_key.caKey.0.algorithm
  private_key_pem       = tls_private_key.caKey.0.private_key_pem
  validity_period_hours = var.validityPeriodHours
  early_renewal_hours = var.earlyRenewalHours
  is_ca_certificate = true
  subject {
    common_name = var.caName == null ? "ca-${var.commonName}" : var.caName
  }
}
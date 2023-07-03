resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = var.rsaBits
}

resource "tls_cert_request" "request" {
  #key_algorithm = tls_private_key.key.algorithm
  private_key_pem = tls_private_key.key.private_key_pem
  subject {
    common_name = var.commonName
  }
  uris = concat([var.commonName], var.additionalNames)
  dns_names = concat([var.commonName], var.additionalNames)

}

resource "tls_locally_signed_cert" "cert" {
  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
    "digital_signature",
  ]
  ca_cert_pem = var.ca == null ? tls_self_signed_cert.caCert.0.cert_pem : var.ca.crt
  #ca_key_algorithm = var.ca == null ?  tls_private_key.caKey.0.algorithm : var.ca.algorithm
  ca_private_key_pem = var.ca == null ? tls_private_key.caKey.0.private_key_pem : var.ca.key
  cert_request_pem = tls_cert_request.request.cert_request_pem
  validity_period_hours = var.validityPeriodHours
  early_renewal_hours = var.earlyRenewalHours
}


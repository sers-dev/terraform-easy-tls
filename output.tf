locals {
  outputs = {
    "tls.crt" = tls_locally_signed_cert.cert.cert_pem
    "tls.key" = tls_private_key.key.private_key_pem
    "ca.crt"  = var.ca == null ? tls_self_signed_cert.caCert.0.cert_pem : var.ca.crt
  }
  caKey = var.ca == null ? tls_private_key.caKey.0.private_key_pem : var.ca.key
  caBundle = "${local.outputs["ca.crt"]}${local.outputs["tls.crt"]}"
}
output "all" {
  sensitive = true
  value     = local.outputs
}

output "tls" {
  sensitive = true
  value = {
    crt = local.outputs["tls.crt"]
    key = local.outputs["tls.key"]
  }
}

output "ca" {
  sensitive = true
  value = {
    crt = local.outputs["ca.crt"]
    key = local.caKey
  }
}

output "crt" {
  value = {
    ca  = local.outputs["ca.crt"]
    tls = local.outputs["tls.crt"]
  }
}

output "caBundle" {
  value = local.caBundle
}
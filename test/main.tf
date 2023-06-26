module "this" {
  source = "../"

  commonName = "test"

  additionalNames = [
    "test.namespace",
    "test.svc.namespace",
    "test.namespace.cluster.local",
  ]
}

module "reuse-ca" {
  source = "../"

  commonName = "same-ca"
  additionalNames = [
    "same-ca.namespace",
    "same-ca.svc.namespace",
    "same-ca.namespace.cluster.local",
  ]

  ca = module.this.ca
}

output "all" {
  sensitive = true
  value = module.this.all
}

output "ca" {
  sensitive = true
  value = module.this.ca
}

output "tls" {
  sensitive = true
  value = module.this.tls
}

output "crt" {
  value = module.this.crt
}

output "caBundle" {
  value = module.this.caBundle
}
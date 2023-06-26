variable "caName" {
  default     = null
  description = "Defaults to 'ca-' + var.commonName. Ignored if `var.ca` is provided"
}

variable "commonName" {
  type = string
}

variable "additionalNames" {
  type = list(string)
}

variable "rsaBits" {
  type        = string
  description = "Bits used for generated keys. Defaults to 4096"
  default     = 4096
}

variable "validityPeriodHours" {
  type        = string
  description = "Validity period of the self signed cert and ca. Defaults to 100 years"
  default     = 876000
}

variable "earlyRenewalHours" {
  type        = string
  description = "Minimum remaining validity period before terraform will update the cert. Defaults to 10 years"
  default     = 87600
}

variable "ca" {
  type = object({
    crt       = string
    key       = string
  })
  default     = null
  description = "If CA is provided it won't generate a custom CA to sign the cert. Allows you to re-use a CA previously created by this module"
}
## [1.0.0] - 2023-06-26

- initial release
- can generate custom ca or will use provided ca from input to sign cert
- allows configuration of rsa_bits, validity_period and early_renewal_period
- provides the following outputs:
  - `all` - can be used as data for a `kubernetes_secret` as it is
  - `ca` - crt and key of the CA used to sign the certificate
  - `tls` - crt and key of the signed certificate
  - `crt` - crt of both the ca and the signed certificate
    - this output is the only one not marked sensitive in case you want/need to display the values on the cli
    - can be used to add the CA to your trust store
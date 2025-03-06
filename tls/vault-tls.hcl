ui = true

storage "file" {
  path = "/etc/vault.d/data"
}

# HTTPS listener
listener "tcp" {
  address       = "127.0.0.1:8200"
  tls_cert_file = "/etc/vault.d/tls/tls.crt"
  tls_key_file  = "/etc/vault.d/tls/tls.key"
}

resource "random_password" "ipsec_shared_secret" {
  length  = 24
  lower   = true
  special = false
}

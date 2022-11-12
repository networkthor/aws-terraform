// Create private key

resource "tls_private_key" "tls_priv_key" {
  algorithm = "RSA"
}

// Generate self-signed certificate
resource "tls_self_signed_cert" "self_cert" {
  private_key_pem = tls_private_key.tls_priv_key.private_key_pem

  subject {
    common_name  = var.domain_name
    organization = var.organization_name
  }

  validity_period_hours = 25000

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.tls_priv_key.private_key_pem
  certificate_body = tls_self_signed_cert.self_cert.cert_pem
}
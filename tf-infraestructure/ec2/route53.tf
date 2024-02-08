resource "aws_route53_record" "fw_domain" {
  zone_id    = local.dns_zone_id
  name       = "acceso.${local.domain_name[terraform.workspace]}"
  type       = "A"
  ttl        = 300
  records    = [aws_instance.pfsense.public_ip]
  depends_on = [aws_instance.pfsense]
}
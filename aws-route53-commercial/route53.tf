data "aws_route53_zone" "primary" {
  name = "example.com"
}

# Internally resolve resource on the VPC to the internal LB
resource "aws_route53_record" "www-dev" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "*"
  type    = "CNAME"
  ttl     = "5"

  records = [var.external_lb_private_dns_name]
}
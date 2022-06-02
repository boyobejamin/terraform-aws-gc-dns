resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = aws_vpc.example.id
  }
}

# Internally resolve resource on the VPC to the internal LB
resource "aws_route53_record" "www-dev" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "*"
  type    = "CNAME"
  ttl     = "5"

  records = [aws_lb.private.dns_name]
}
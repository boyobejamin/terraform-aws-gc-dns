output "route53" {
  value = {
    arn          = aws_route53_zone.primary.arn
    zone_id      = aws_route53_zone.primary.zone_id
    name_servers = aws_route53_zone.primary.name_servers
  }
}
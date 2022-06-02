output "aws_public_lb" {
  value = {
    id             = aws_lb.public.id
    arn            = aws_lb.public.arn
    dns_name       = aws_lb.public.dns_name
    zone_id        = aws_lb.public.zone_id
    security_group = aws_security_group.allow_web.id
  }
}

output "aws_private_lb" {
  value = {
    id             = aws_lb.private.id
    arn            = aws_lb.private.arn
    dns_name       = aws_lb.private.dns_name
    zone_id        = aws_lb.private.zone_id
    security_group = aws_security_group.allow_web.id
  }
}

output "aws_s3_terraform_state" {
  value = {
    id                          = aws_s3_bucket.tfstate_bucket.id
    arn                         = aws_s3_bucket.tfstate_bucket.arn
    bucket_domain_name          = aws_s3_bucket.tfstate_bucket.bucket_domain_name
    bucket_regional_domain_name = aws_s3_bucket.tfstate_bucket.bucket_regional_domain_name
    hosted_zone_id              = aws_s3_bucket.tfstate_bucket.hosted_zone_id
    region                      = aws_s3_bucket.tfstate_bucket.region
    tags_all                    = aws_s3_bucket.tfstate_bucket.tags_all
  }
}
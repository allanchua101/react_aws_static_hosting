data "aws_route53_zone" "base_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "cname" {
  zone_id = data.aws_route53_zone.base_zone.zone_id
  name    = var.sub_domain
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_cloudfront_distribution.website_cdn.domain_name
  ]
}

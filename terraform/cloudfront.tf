resource "aws_cloudfront_distribution" "website_cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = join("", ["CF distribution for ", local.project_env_name])
  default_root_object = "index.html"
  price_class         = "PriceClass_All"
  provider            = aws.global
  web_acl_id          = aws_wafv2_web_acl.waf.arn

  aliases = [var.sub_domain]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    domain_name = aws_s3_bucket.main_bucket.bucket_regional_domain_name
    origin_id   = "main"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website_oai.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = aws_s3_bucket.failover_bucket.bucket_regional_domain_name
    origin_id   = "failover"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website_oai.cloudfront_access_identity_path
    }
  }

  origin_group {
    origin_id = join("-", [local.project_env_name, "origin-group"])

    failover_criteria {
      status_codes = [403, 404, 500, 502]
    }

    member {
      origin_id = "main"
    }

    member {
      origin_id = "failover"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = join("-", [local.project_env_name, "origin-group"])
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  
    # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern               = "index.html"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    target_origin_id           = join("-", [local.project_env_name, "origin-group"])
    response_headers_policy_id = aws_cloudfront_response_headers_policy.disarm_cache_headers_policy.id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern               = "/"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    target_origin_id           = join("-", [local.project_env_name, "origin-group"])
    response_headers_policy_id = aws_cloudfront_response_headers_policy.disarm_cache_headers_policy.id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.acm_cert_arn
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name = join("-", [local.project_env_name, "cf-distribution"])
  }
}

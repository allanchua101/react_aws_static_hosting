resource "aws_cloudfront_response_headers_policy" "disarm_cache_headers_policy" {
  name = join("-", [local.project_env_name, "index-headers-policy"])

  custom_headers_config {
    items {
      header   = "permissions-policy"
      override = true
      value    = "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
    }

    items {
      header   = "server"
      override = true
      value    = "non-embeddable-server"
    }

    items {
      header   = "Cache-Control"
      override = true
      value    = "no-cache, no-store, max-age=5" # Set to 5 seconds only
    }
  }

  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }
    strict_transport_security {
      access_control_max_age_sec = "63072000"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    # Research CSP
    # content_security_policy {
    #   content_security_policy = ""
    #   override                = true
    # }
  }
}

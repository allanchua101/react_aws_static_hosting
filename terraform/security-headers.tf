resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = join("-", [local.project_env_name, "security-headers-policy"])

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
    # Research CSP policy
    # content_security_policy {
    #   override                = true
    # }
  }
}

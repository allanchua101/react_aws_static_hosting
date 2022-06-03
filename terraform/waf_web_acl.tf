resource "aws_wafv2_web_acl" "waf" {
  provider = aws.global
  depends_on = [
    aws_wafv2_rule_group.waf_rule_group
  ]

  name  = join("-", [local.project_env_name, "waf_web_acl"])
  scope = "CLOUDFRONT"

  default_action {
    block {
      custom_response {
        response_code = 404
      }
    }
  }

  rule {
    name     = "waf_rules"
    priority = 1

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.waf_rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "waf_acl_rg"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "waf_acl"
    sampled_requests_enabled   = false
  }
}

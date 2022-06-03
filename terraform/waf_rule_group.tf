resource "aws_wafv2_rule_group" "waf_rule_group" {
  provider = aws.global
  name     = join("-", [local.project_env_name, "waf_rg"])
  scope    = "CLOUDFRONT"
  capacity = 2

  rule {
    name     = "ipset_rule"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.waf_ipv4_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "waf_ip4_ipsetrule_metrics"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "waf_ip4_rg_metrics"
    sampled_requests_enabled   = false
  }
}

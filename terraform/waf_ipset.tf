resource "aws_wafv2_ip_set" "waf_ipv4_set" {
  name               = join("-", [local.project_env_name, "waf_ipv4_ipset"])
  description        = "WAF IP set for whitelisting of users"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.ipv4_whitelist
  provider           = aws.global
}

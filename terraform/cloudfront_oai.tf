resource "aws_cloudfront_origin_access_identity" "website_oai" {
  comment = join("", ["OAI for ", local.project_env_name, "'s cloudfront."])
}

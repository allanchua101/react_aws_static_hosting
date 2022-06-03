resource "aws_s3_bucket" "failover_bucket" {
  bucket = join("-", [local.project_env_name, "website-failover-s3"])

  tags = {
    Name = join("-", [local.project_env_name, "website-failover-s3"]),
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "failover_bucket_encryption" {
  bucket = aws_s3_bucket.failover_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "failover_bucket_acl" {
  bucket = aws_s3_bucket.failover_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "failover_bucket_access_block" {
  bucket = aws_s3_bucket.failover_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "failover_bucket_iam_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.failover_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.website_oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "failover_s3_policy" {
  bucket = aws_s3_bucket.failover_bucket.id
  policy = data.aws_iam_policy_document.failover_bucket_iam_policy.json
}

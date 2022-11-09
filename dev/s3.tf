resource "aws_s3_bucket" "ssm_patch_log_bucket" {
  bucket = "weinberg-s3-${var.environment}-ssm-patch-logs-bucket"
  tags = var.tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.ssm_patch_log_bucket.id
  acl    = "private"
}

###############
# Create Centralized S3 bucket logs
###############
#resource "aws_s3_bucket" "ssm_patch_log_bucket" {
#  bucket = "s3-${var.environment}-ssm-patch-logs-bucket"
#  acl    = "private"
#tags = merge({Name = "s3-${var.environment}-ssm-patch-logs-bucket"}, var.tags)
#}

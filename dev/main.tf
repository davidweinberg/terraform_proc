provider "aws" {
  access_key = "AKIAR5NSQ2ZULWMWVZUW"
  secret_key = "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"
  region     = var.aws_region
}

#module "ssm-patch-management" {
#  source  = "jparnaudeau/ssm-patch-management/aws"
##  version = "1.1.2"
#}


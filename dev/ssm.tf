locals {
  operating_system_amazon_linux2  = "AMAZON_LINUX_2"
}

#####
# Create Patch Baselines for amazonlinux
#####

module "patch_baseline_amazonlinux2" {
  source = "../modules/patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_amazon_linux2
  description                       = "AmazonLinux2 - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 7
      compliance_level    = "CRITICAL"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["AmazonLinux2", "AmazonLinux2.0"]
        },
        {
          name   = "CLASSIFICATION"
          values = ["Security"]
        },
        {
          name   = "SEVERITY"
          values = ["Critical"]
        }
      ]
    }
  ]

  # parameters for scan : associated patch_group "scan" to this patch baseline
  enable_mode_scan = true
}

# register as default patch baseline our patch baseline
/*
module "register_patch_baseline_amazonlinux2" {
  source = "../modules/register_default_patch_baseline"

  region                     = var.aws_region
  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_amazonlinux2.patch_baseline_id
  operating_system           = local.operating_system_amazon_linux2
}
*/

###############
# Create PatchManagement Maintenance Windows
# - one maintenance windows for scanning all ec2 Instances with tag "Patch Group" = "TOSCAN" every day at 08:00 CET
# - one maintenance windows for patching ec2 Instances with tag "Patch Group" = "TOPATCH" and "App" = "myapp" and "Critical" = "no", every sunday at 20:00 CET
###############
module "ssm-patch-management" {
  source = "../modules/maintenance_windows"

  # tags parameters
  environment = var.environment
  #  tags = var.tags

  # global parameters
  s3_bucket_name   = aws_s3_bucket.ssm_patch_log_bucket.id
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn

  # parameters for scan
  enable_mode_scan                 = true
  scan_maintenance_window_schedule = "cron(0 15 3 ? * * *)"
  s3_bucket_prefix_scan_logs       = format("scan/%s", var.ssm_patch_logs_prefix)
  #scan_maintenance_windows_targets = var.tags
  # By default, maintenance_windows_targets use the tag "Patch Group" = var.scan_patch_groups
  #   scan_maintenance_windows_targets = [
  #   {
  #   key    = "tag:Patch Group"
  #   values = ["TOSCAN"]
  #   }
  # ]

  # parameters for install
  install_maintenance_window_schedule = "cron(0 45 4 ? * WED *)"
  s3_bucket_prefix_install_logs       = format("install/%s", var.ssm_patch_logs_prefix)
  #  install_maintenance_windows_targets = [
  #  {
  #    key    = "tag:App"
  #    values = ["myapp"]
  #  },
  #  {
  #    key    = "tag:Critical"
  #    values = ["no"]
  #  }
  #]

  # enable SNS notification for install
  #enable_notification_install = true
  #notification_arn            = aws_sns_topic.ssm_patch_sns.arn
  #notification_events         = ["Success", "Failed"] # Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed

}




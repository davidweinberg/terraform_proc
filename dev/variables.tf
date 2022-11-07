variable "aws_region" {
  description = "The AWS region to create this project's resource in"
  type = string
  default = "us-east-1"
}

variable "environment" {
  description = "environment type"
  type = string
  default = "dev"
}

variable "profile" {
  description = "This label will be added to the SSM baseline description"
  type = string
  default = "EC2_Admin"
}

variable "approved_patches" {
  description = "The list of approved patches for the SSM baseline"
  type = list(string)
  default = []
}

variable "rejected_patches" {
  description = "The list of rejected patches for the SSM baseline"
  type = list(string)
  default = []
}

variable "product_version" {
  description = "The list of product version for the SSM baseline"
  default = ["AmazonLinux2"]
}

variable "patch_classification" {
  description = "The list of patch classifications for the SSM baseline"
  type = list(string)
  default = ["CiticalUpdates", "SecurityUpdates"]
}

variable "patch_severity" {
  description = "The list of patch serverities for the SSm basline"
  type = list(string)
  default = ["Cirtical", "Important"]
}

variable "tags" {
  type = map(string)
  default = {Environment = "dev"}
}

resource "aws_iam_role" "ssm_role" {
    name = "ssm_role"

    assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {"Service": "ec2.amazonaws.com"},
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  #policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  for_each  = toset([
"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
"arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ])
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ssm_policy" {
  name = "ssm_policy"
  role = aws_iam_role.ssm_role.name
}

###############
# Create Custom Role for patchManagement
# and attach AmazonSSMMaintenanceWindowRole policy to the role
###############
resource "aws_iam_role" "ssm_maintenance_window" {
  name = "role-${var.environment}-ssm-mw-role"
  path = "/system/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com","ssm.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "role_attach_ssm_mw" {
  role       = aws_iam_role.ssm_maintenance_window.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}


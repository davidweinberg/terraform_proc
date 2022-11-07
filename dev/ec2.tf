/*resource "aws_ssm_activation" "foo" {
  name               = "test_ssm_activation"
  description        = "Test"
  iam_role           = aws_iam_role.test_role.id
  depends_on         = [aws_iam_role_policy_attachment.test_attach]
}*/
resource "aws_instance" "example" {
  #ami           = "ami-081dc0707789c2daf" #ARM
  ami            = "ami-09d3b3274b6c5d4aa" #x86
  instance_type = "t2.micro"
  tags = var.tags
  #iam_instance_profile = "SSMInstanceProfile"
  iam_instance_profile = aws_iam_instance_profile.ssm_policy.name
}

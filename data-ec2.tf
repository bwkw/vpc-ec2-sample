# Amazon Linux 2 の最新版AMIを取得
data "aws_ami" "amazon_linux_2_arm64" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

locals {
  ec2_instance_type = "t2.micro"
}

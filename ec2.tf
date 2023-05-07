# ---------------------------
# EC2
# ---------------------------

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

# EC2作成
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon_linux_2_arm64.id
  instance_type               = var.ec2_instance_type
  availability_zone           = var.availability_zone_a
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = aws_subnet.pub_sub_1a.id
  associate_public_ip_address = "true"
  iam_instance_profile        = aws_iam_instance_profile.systems_manager.name
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 20
  }
  tags = {
    Name = "${var.environment}-${var.app_name}-ec2"
  }
}

# IAMロール
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "EC2Role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

resource "aws_iam_instance_profile" "systems_manager" {
  name = "SystemsManagerProfile"
  role = aws_iam_role.role.name
}

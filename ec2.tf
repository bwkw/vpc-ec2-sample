# ---------------------------
# EC2
# ---------------------------

# EC2作成
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon_linux_2_arm64.id
  instance_type               = local.ec2_instance_type
  availability_zone           = local.availability_zone_a
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
  name               = "${var.environment}-${var.app_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = {
    Name = "${var.environment}-${var.app_name}-ec2-role"
  }
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

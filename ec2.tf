# ---------------------------
# EC2
# ---------------------------

# Amazon Linux 2 の最新版AMIを取得
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2作成
resource "aws_instance" "ec2" {
  ami                         = data.aws_ssm_parameter.amzn2_latest_ami.value
  instance_type               = "t2.micro"
  availability_zone           = var.availability_zone_a
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = aws_subnet.pub_sub_1a.id
  associate_public_ip_address = "true"
  iam_instance_profile        = aws_iam_instance_profile.systems_manager.name
  tags = {
    Name = "terraform-ec2"
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

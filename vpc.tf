# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_cidr
  tags = {
    Name = "${var.environment}-${var.app_name}-vpc"
  }
}

# ---------------------------
# Subnet
# ---------------------------
resource "aws_subnet" "pub_sub_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.pub_sub_1a_cidr
  availability_zone = local.availability_zone_a
  tags = {
    Name = "${var.environment}-${var.app_name}-public-1a-sub"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-${var.app_name}-igw"
  }
}

# ---------------------------
# Route table
# ---------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment}-${var.app_name}-public-rt"
  }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "public_rt_associate" {
  subnet_id      = aws_subnet.pub_sub_1a.id
  route_table_id = aws_route_table.public_rt.id
}

# ---------------------------
# Security Group
# ---------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-${var.app_name}-ec2-sg"
  description = "For EC2"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-${var.app_name}-ec2-sg"
  }

  # インバウンドルール
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allow_ip_list
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allow_ip_list
  }

  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

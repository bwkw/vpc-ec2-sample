data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zone_a = data.aws_availability_zones.available.names[0]
  vpc_cidr            = "192.168.0.0/16"
  pub_sub_1a_cidr     = "192.168.0.0/24"
}

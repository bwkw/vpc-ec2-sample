# ---------------------------
# 変数設定
# ---------------------------
variable "allow_ip_list" {}
variable "availability_zone_a" {
  default = "ap-northeast-1a"
}
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "pub_sub_1a_cidr" {
  default = "192.168.0.0/24"
}
variable "ec2_instance_type" {
  default = "t4g.small"
}
variable "environment" {
  default = "stg"
}
variable "app_name" {
  default = "sample"
}

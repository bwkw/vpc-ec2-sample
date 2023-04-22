# ---------------------------
# 変数設定
# ---------------------------
variable "access_key" {}
variable "secret_key" {}
variable "my_ip" {}
variable "availability_zone_a" {
  default = "ap-northeast-1a"
}
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "pub_sub_1a_cidr" {
  default = "192.168.0.0/24"
}

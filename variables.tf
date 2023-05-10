# ---------------------------
# 変数設定
# ---------------------------
variable "allow_ip_list" {
  type = list(string)
}
variable "environment" {
  type    = string
  default = "stg"
}
variable "app_name" {
  type    = string
  default = "sample"
}

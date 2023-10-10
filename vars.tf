# vim: set ft=tf:

variable "folder_id" {
  type = string
}

variable "region" {
  type = string
  default = "changeme"
}

variable "network_name" {
  type = string
  default = "changeme"
}

variable "subnet_name" {
  type = string
  default = "changeme"
}

variable "subnet_a_name" {
  type = string
  default = "changeme"
}

variable "subnet_b_name" {
  type = string
  default = "changeme"
}

variable "subnet_c_name" {
  type = string
  default = "changeme"
}

variable "sys_admin_user" {
  type = object({
    user_name = string
    ssh_pub_key = string
  })
}


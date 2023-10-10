# vim: set ft=tf expandtab softtabstop=2:

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "node_group_version" {
  type = string
}

variable "platform_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "memory" {
  type = number
}

variable "cores" {
  type = number
}

variable "boot_disk_type" {
  type = string
  default = "network-ssd-nonreplicated"
}

variable "boot_disk_size" {
  type = number
  default = 93
}

 variable "fixed_scale_size" {
  type = number
}

variable "zone" {
  type = string
}

variable "maintenance_policy" {
  type = bool
  default = false
}

variable "auto_repair" {
  type = bool
  default = false
}

variable "maintenance_day" {
  type = string
  default = "friday"
}

variable "maintenance_start_time" {
  type = string
  default = "1:00"
}

variable "maintenance_duration" {
  type = string
  default = "3h"
}


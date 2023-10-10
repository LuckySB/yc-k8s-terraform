# vim: set ft=tf expandtab softtabstop=2:

locals {
  description = "Created from iaac-marketplace/kubernetes/terraform project"
  cluster_sa_name = "${var.cluster_name}-cluster-sa"
  node_sa_name = "${var.cluster_name}-node-sa"
}

variable "folder_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "subnet_c_id" {
  type = string
}

variable "cluster_ipv4_range" {
  type = string
}

variable "service_ipv4_range" {
  type = string
}

variable "region" {
  type = string
}

variable "zone_a" {
  type = string
}

variable "zone_b" {
  type = string
}

variable "zone_c" {
  type = string
}

variable "node_group_a_name" {
  type = string
}

variable "node_group_b_name" {
  type = string
}

variable "node_group_c_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_k8s_version" {
  type = string
}

variable "cluster_public_ip" {
  type = bool
  default = false
}

variable "cluster_maintenance_policy" {
  type = bool
  default = false
}

variable "cluster_auto_repair" {
  type = bool
  default = false
}

variable "cluster_maintenance_start_time" {
  type = string
  default = "1:00"
}

variable "cluster_maintenance_duration" {
  type = string
  default = "3h"
}

variable "cluster_release_channel" {
  type = string
  default = "RAPID"
}

variable "cluster_release_network_provider" {
  type = string
  default = "CALICO"
}

variable "cluster_nodes_platform_id" {
  type = string
  default = "standard-v1"
}

variable "cluster_nodes_memory" {
  type = number
  default = 32
}

variable "cluster_nodes_cores" {
  type = number
  default = 4
}

variable "cluster_nodes_boot_disk_type" {
  type = string
  default = "network-hdd"
}

variable "cluster_nodes_boot_disk_size" {
  type = number
  default = 96
}

variable "cluster_nodes_fixed_scale" {
  type = number
  default = 4
}


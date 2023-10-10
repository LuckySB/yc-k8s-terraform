# vim: set ft=tf expandtab softtabstop=2:

terraform {
  required_version = ">= 0.14"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.99"
    }
  }
}


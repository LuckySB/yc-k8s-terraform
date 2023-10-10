
terraform {
  required_version = ">= 0.14"

  backend "http" {}

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.99"
    }
  }
}

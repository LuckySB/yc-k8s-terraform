# vim: set ft=tf expandtab softtabstop=2:

resource "yandex_kubernetes_node_group" "node_group" {
  name            = var.name
  description     = var.description
  cluster_id      = var.cluster_id
  version         = var.node_group_version


  instance_template {
    platform_id   = var.platform_id

    network_interface {
      nat         = true
      subnet_ids  = [ var.subnet_id ]
      security_group_ids = var.security_group_ids
    }

    resources {
      memory      = var.memory
      cores       = var.cores
    }

    boot_disk {
      type        = var.boot_disk_type
      size        = var.boot_disk_size
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size        = var.fixed_scale_size
    }
  }

  allocation_policy {
    location {
      zone        = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade  = var.maintenance_policy
    auto_repair   = var.auto_repair

    maintenance_window {
      day         = var.maintenance_day
      start_time  = var.maintenance_start_time
      duration    = var.maintenance_duration
    }
  }
}


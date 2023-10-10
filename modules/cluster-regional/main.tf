# vim: set ft=tf expandtab softtabstop=2:

resource "yandex_iam_service_account" "cluster_sa" {
  name            = local.cluster_sa_name
  description     = local.description
  folder_id       = var.folder_id
}

resource "yandex_iam_service_account" "node_sa" {
  name            = local.node_sa_name
  description     = local.description
  folder_id       = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "cluster_sa_folder_member_1" {
  role            = "k8s.clusters.agent"
  member          = "serviceAccount:${yandex_iam_service_account.cluster_sa.id}"
  folder_id       = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "cluster_sa_folder_member_2" {
  role            = "load-balancer.admin"
  member          = "serviceAccount:${yandex_iam_service_account.cluster_sa.id}"
  folder_id       = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "cluster_sa_folder_member_3" {
  role            = "vpc.publicAdmin"
  member          = "serviceAccount:${yandex_iam_service_account.cluster_sa.id}"
  folder_id       = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "node_sa_folder_member_1" {
  role            = "container-registry.images.puller"
  member          = "serviceAccount:${yandex_iam_service_account.node_sa.id}"
  folder_id       = var.folder_id
}

#resource "yandex_resourcemanager_folder_iam_member" "node_sa_folder_member_2" {
#  role            = "container-registry.images.pusher"
#  member          = "serviceAccount:${yandex_iam_service_account.node_sa.id}"
#  folder_id       = var.folder_id
#}

module "security_group" {
  source                    = "../security-group"

  cluster_name       = var.cluster_name
  network_id         = var.network_id
  cluster_ipv4_range = var.cluster_ipv4_range
  service_ipv4_range = var.service_ipv4_range
}

resource "yandex_kubernetes_cluster" "regional_cluster" {
  name            = var.cluster_name
  description     = local.description
  folder_id       = var.folder_id
  network_id      = var.network_id

  cluster_ipv4_range        = var.cluster_ipv4_range
  service_ipv4_range        = var.service_ipv4_range

  master {
    version       = var.cluster_k8s_version

    regional {
      region      = var.region

      location {
        zone      = var.zone_a
        subnet_id = var.subnet_a_id
      }

      location {
        zone      = var.zone_b
        subnet_id = var.subnet_b_id
      }

      location {
        zone      = var.zone_c
        subnet_id = var.subnet_c_id
      }
    }

    public_ip     = var.cluster_public_ip

    security_group_ids = [
      module.security_group.k8s-control-plane-id
    ]

    maintenance_policy {
      auto_upgrade          = var.cluster_maintenance_policy

      maintenance_window {
        start_time          = var.cluster_maintenance_start_time
        duration            = var.cluster_maintenance_duration
      }
    }
  }

  service_account_id        = yandex_iam_service_account.cluster_sa.id
  node_service_account_id   = yandex_iam_service_account.node_sa.id

  depends_on = [
    yandex_iam_service_account.cluster_sa,
    yandex_iam_service_account.node_sa,
    yandex_resourcemanager_folder_iam_member.cluster_sa_folder_member_1,
    yandex_resourcemanager_folder_iam_member.cluster_sa_folder_member_2,
    yandex_resourcemanager_folder_iam_member.cluster_sa_folder_member_3,
    yandex_resourcemanager_folder_iam_member.node_sa_folder_member_1
  ]

  release_channel           = var.cluster_release_channel
  network_policy_provider   = var.cluster_release_network_provider
}

module "node_group_a" {
  source                    = "../node-group-zonal"
  name                      = var.node_group_a_name
  description               = local.description
  cluster_id                = yandex_kubernetes_cluster.regional_cluster.id
  node_group_version        = var.cluster_k8s_version
  platform_id               = var.cluster_nodes_platform_id
  subnet_id                 = var.subnet_a_id
  security_group_ids        = [ module.security_group.k8s-node-group-id ]
  memory                    = var.cluster_nodes_memory
  cores                     = var.cluster_nodes_cores
  boot_disk_type            = var.cluster_nodes_boot_disk_type
  boot_disk_size            = var.cluster_nodes_boot_disk_size
  fixed_scale_size          = var.cluster_nodes_fixed_scale
  auto_repair               = var.cluster_auto_repair
  zone                      = var.zone_a
}

module "node_group_b" {
  source                    = "../node-group-zonal"
  name                      = var.node_group_b_name
  description               = local.description
  cluster_id                = yandex_kubernetes_cluster.regional_cluster.id
  node_group_version        = var.cluster_k8s_version
  platform_id               = var.cluster_nodes_platform_id
  subnet_id                 = var.subnet_b_id
  security_group_ids        = [ module.security_group.k8s-node-group-id ]
  memory                    = var.cluster_nodes_memory
  cores                     = var.cluster_nodes_cores
  boot_disk_type            = var.cluster_nodes_boot_disk_type
  boot_disk_size            = var.cluster_nodes_boot_disk_size
  fixed_scale_size          = var.cluster_nodes_fixed_scale
  auto_repair               = var.cluster_auto_repair
  zone                      = var.zone_b
}

module "node_group_c" {
  source                    = "../node-group-zonal"
  name                      = var.node_group_c_name
  description               = local.description
  cluster_id                = yandex_kubernetes_cluster.regional_cluster.id
  node_group_version        = var.cluster_k8s_version
  platform_id               = var.cluster_nodes_platform_id
  subnet_id                 = var.subnet_c_id
  security_group_ids        = [ module.security_group.k8s-node-group-id ]
  memory                    = var.cluster_nodes_memory
  cores                     = var.cluster_nodes_cores
  boot_disk_type            = var.cluster_nodes_boot_disk_type
  boot_disk_size            = var.cluster_nodes_boot_disk_size
  fixed_scale_size          = var.cluster_nodes_fixed_scale
  auto_repair               = var.cluster_auto_repair
  zone                      = var.zone_c
}


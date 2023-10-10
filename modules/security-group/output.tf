output "k8s-control-plane-id" {
  value = yandex_vpc_security_group.k8s-control-plane.id
}

output "k8s-node-group-id" {
  value = yandex_vpc_security_group.k8s-node-group.id
}

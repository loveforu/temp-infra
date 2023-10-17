output "cluster_node_sg_id" {
  value = module.app_cluster.node_security_group_id
}

output "nodegroup" {
  value = local.node_groups
}
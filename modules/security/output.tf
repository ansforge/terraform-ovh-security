output "private_key_pem" {
  value     = tls_private_key.instance_key.private_key_pem
  sensitive = true
}

output "instance_id" {
  value = openstack_compute_instance_v2.fw.id
}

output "port_ids" {
  value = { for k, v in openstack_networking_port_v2.ports : k => v.id }
}

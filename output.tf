output "moodle_public_ip" {
  value = module.moodle.public_ip
}

output "moodle_db_user" {
  value = module.moodle.moodle_user_name
}

output "moodle_schema" {
  value = module.moodle.moodle_schema_name
}

output "moodle_db_password" {
  value = var.moodle_password
  sensitive = true
}

output "mds_instance_ip" {
  value = module.mds-instance.private_ip
}

output "ssh_private_key" {
  value = local.private_key_to_show
  sensitive = true
}

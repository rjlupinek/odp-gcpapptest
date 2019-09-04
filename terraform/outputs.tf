
output "postgres_instance" {
  value = "${google_sql_database_instance.postgres.connection_name}"
  description = "Postgres instance ID"
}


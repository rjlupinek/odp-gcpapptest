// Production Postgres Database
resource "google_sql_database_instance" "postgres" {
  name = "pypostgres"
  database_version = "POSTGRES_9_6"
  region = "${var.region}"

  settings {
    tier = "db-f1-micro"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled = true
      start_time = "05:00"
    }
  }
}

resource "google_sql_user" "postgres" {
  name     = "${var.cloudsql_username}"
  password = "${var.cloudsql_password}"
  instance = "${google_sql_database_instance.postgres.name}"
}

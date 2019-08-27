// Production Postgres Database
resource "google_sql_database_instance" "postgres" {
  name = "postgresdb"
  database_version = "POSTGRES_9_6"
  region = "${var.region}"

  settings {
    tier = "db-f1-micro"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled = true
      start_time = "05:00"
    }
    maintenance_window {
      day = "6"
      hour = "2" #UTC = EST + 4
      update_track = "stable"
    }
  }
}

resource "google_sql_user" "postgres" {
  name     = "${var.cloudsql_username}"
  password = "${var.cloudsql_password}"
  instance = "${google_sql_database_instance.postgres.name}"
}

// Production Postgres Database
resource "google_sql_database_instance" "postgres" {
  name = "${var.cloudsql_db_name}"
  database_version = "POSTGRES_9_6"
  region = "${var.region}"

  settings {
    tier = "${var.cloudsql_tier}"
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
